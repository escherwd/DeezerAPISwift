//
//  getUserFavArtists.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/18/25.
//

extension DeezerAPI {
    
    public func getUserFavArtists(forUserId: Int? = nil) async throws -> ([DeezerArtist], String) {
        
        if (forUserId == nil) {
            try await self.refreshTokensFromArl()
        }
        
        guard let uid = forUserId ?? self.userId else {
            throw DeezerApiError.invalidRequest
        }
        
        let artistsRes: pageProfileBase<pageProfileArtists> = try await self.requestGwLight("deezer.pageProfile", body: [
            "nb": 2000,
            "start": 0,
            "tab": "artists",
            "user_id": "\(uid)"
        ])
        
        let artists = try artistsRes.TAB.artists.data.map { try DeezerArtist.fromFragmentArtistResponse($0) }
        
        return (artists, artistsRes.TAB.artists.checksum)
        
    }
    
}
