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
        
        // Before anything else, ensure we have the blowfish key
        let blowfishKey = try DeezerApiEncryption.generateBlowfishKey(
            trackId: media.trackId
        )

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

        // Decryption utilities
        let decryptChunkSize = 2048 * 3  // 6144

        
        
        // Allocate 500kb for decrypting the track
        let processBufferCapacity = 1024 * 500
        var processBuffer = Data(capacity: processBufferCapacity)
        
        
        // Open the file handler
        let outUrl = URL.documentsDirectory.appending(
            path:
                "decrypted_\(media.trackId).\(media.format == .flac ? "flac" : "mp3")"
        )
        if !FileManager.default.createFile(atPath: outUrl.path(), contents: nil) {
            throw DeezerApiError.mediaNotAvailable
        }
//        try outputData.write(to: outUrl, options: .atomic)
        let fileHandle = try FileHandle(forWritingTo: outUrl)
        

        for try await var chunk in response.body {
            
            finishedBytes += chunk.readableBytes
            let prog = Double(finishedBytes) / Double(expectedBytes) * 100
            print("Progress: \(prog)% - \(chunk.readableBytes/1024) kb")
            
            // Read the data of this chunk
            guard let chunkData = chunk.readData(length: chunk.readableBytes)
            else {
                continue
            }
            
            // Continue building entire inputData buffer
            //            outputData.append(chunkData)
            processBuffer.append(chunkData)
            
            
            if processBuffer.count >= decryptChunkSize * 25 || expectedBytes - finishedBytes <= decryptChunkSize * 5 {
                
                var readHead = 0
                
                while processBuffer.count - readHead >= decryptChunkSize {
                    
                    // Only the first 2048 bytes of the chunk actually need to be decrypted
                    let range = readHead..<(readHead + 2048)
                    
                    // Decrypt the data in-place
                    let decBlock = Data(
                        try Blowfish(
                            key: blowfishKey.bytes,
                            blockMode: CBC(iv: [0, 1, 2, 3, 4, 5, 6, 7]),
                            padding: .noPadding
                        ).decrypt(processBuffer.bytes[range])
                    )
                    
                    processBuffer[range] = decBlock
                    
                    readHead += decryptChunkSize
                    
                }
                
                // Write out up to the read head
                try fileHandle.write(contentsOf: processBuffer[..<readHead])
                // Clear the buffer
                processBuffer = Data(processBuffer.bytes[readHead...])
                processBuffer.reserveCapacity(processBufferCapacity)
                
                // Delete unused responses
                chunk.clear()
                
            }
            
        }
            


        
        // Write the remaining data and close
        
        try fileHandle.write(contentsOf: processBuffer)
        try fileHandle.close()
        

    }

}
