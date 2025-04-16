//
//  getArtist.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/11/25.
//

extension DeezerAPI {
    
    public func getArtist(_ id: Int) async throws -> DeezerArtist {
        
        // Use gwLight request to get an album
        let artistRes: pageArtistResponse = try await requestGwLight("deezer.pageArtist", parameters: [:], body: [
            "art_id": "\(id)",
            "tab": 0,
        ])
        
        return try DeezerArtist.fromPageArtistResponse(artistRes)
        
    }
    
}
