//
//  getTrackUrls.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/14/25.
//

import Foundation

extension DeezerAPI {

    public func getTrackUrls(forTrackToken trackToken: String, andTrackId trackId: Int) async throws
        -> DeezerMedia
    {
        
        if (self.licenseToken == nil) {
            try await self.refreshTokensFromArl()
        }
        
        // If license token is still nil, throw an error
        if (self.licenseToken == nil) {
            throw DeezerApiError.invalidLicense
        }

        let res = try await self.request("https://media.deezer.com/v1/get_url", body: [
            "license_token": self.licenseToken!,
            "track_tokens": [trackToken],
            "media": [
                [
                    "type": "FULL",
                    "formats": DeezerMedia.DeezerMediaFormat.allCases.map {
                        [
                            "format": $0.rawValue.uppercased(),
                            "cipher": "BF_CBC_STRIPE"
                        ] as [String: Any]
                    }
                ]
            ]
        ])

        
        let decoded = try JSONDecoder().decode(getUrlResponse.self, from: res)
        
        guard let media = decoded.data.first?.media.first else {
            throw DeezerApiError.mediaNotAvailable
        }
        
        return DeezerMedia(format: .init(rawValue: media.format.lowercased())!, expires: media.exp, urls: media.sources.map { $0.url }, trackId: trackId)

    }

}
