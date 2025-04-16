//
//  streamTrack.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/14/25.
//

import AsyncHTTPClient
//import CryptoSwift
import CryptoSwift
import Foundation

extension DeezerAPI {

    // TODO: make concurrent

    public func streamTrack(fromMedia media: DeezerMedia) async throws {

        // Right now we'll just use the first available media url
        // Not really sure what the functional difference between streams are
        guard let firstUrl = media.urls.first else {
            throw DeezerApiError.mediaNotAvailable
        }

        // Create an async http client network request
        let req = HTTPClientRequest(url: firstUrl)

        // Download the data
        let response = try await HTTPClient.shared.execute(
            req,
            timeout: .seconds(30)
        )

        // For allocating enough memory and keeping track of download progress
        guard
            let expectedBytes = response.headers.first(name: "content-length")
                .flatMap(Int.init)
        else {
            throw DeezerApiError.invalidResponse
        }

        // For keeping track of the download progress
        var finishedBytes = 0

        // The buffer that the file will be written to
        // Pre-allocate the memory
        var outputData = Data(capacity: expectedBytes)

        // Decryption utilities
        let decryptChunkSize = 2048 * 3  // 6144
        let blowfishKey = DeezerApiEncryption.generateBlowfishKey(
            trackId: media.trackId
        )

        // The read head starts at 0
        var inputReadHead = 0

        for try await var chunk in response.body {

            finishedBytes += chunk.readableBytes
            let prog = Double(finishedBytes) / Double(expectedBytes) * 100
            print("Progress: \(prog)%")

            // Read the data of this chunk
            guard let chunkData = chunk.readData(length: chunk.readableBytes)
            else {
                continue
            }

            // Continue building entire inputData buffer
            outputData.append(chunkData)

            // If some chunks are available, decrypt them before moving on to the next response chunk
            // Do decryption every 50 chunks?
            // At 320kbps this is equivilent to decrypting in 1-second batches
            if outputData.count - inputReadHead >= decryptChunkSize * 50
                || expectedBytes - inputReadHead <= decryptChunkSize * 5
            {
                while outputData.count - inputReadHead >= decryptChunkSize {

                    // Only the first 2048 bytes of the chunk actually need to be decrypted
                    let range = inputReadHead..<(inputReadHead + 2048)

                    // Decrypt the data in-place
                    outputData.replaceSubrange(
                        range,
                        with: Data(
                            try Blowfish(
                                key: blowfishKey.bytes,
                                blockMode: CBC(iv: [0, 1, 2, 3, 4, 5, 6, 7]),
                                padding: .noPadding
                            ).decrypt(outputData.bytes[range])
                        )
                    )

                    // Increment the read head
                    inputReadHead += decryptChunkSize

                }
            }
            
            response.body.dropFirst()

        }

        // Write outputData to disk
        let outUrl = URL.documentsDirectory.appending(
            path:
                "decrypted_\(media.trackId).\(media.format == .flac ? "flac" : "mp3")"
        )
        try outputData.write(to: outUrl, options: .atomic)
        
        

    }

}
