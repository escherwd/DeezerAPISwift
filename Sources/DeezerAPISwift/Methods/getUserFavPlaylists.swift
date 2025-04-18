//
//  getUserFavArtists.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/18/25.
//

extension DeezerAPI {
    
    public func getUserFavPlaylists(forUserId: Int? = nil) async throws -> [DeezerPlaylist] {
        
        if (forUserId == nil) {
            try await self.refreshTokensFromArl()
        }
        
        guard let uid = forUserId ?? self.userId else {
            throw DeezerApiError.invalidRequest
        }
        
        let playlistsRes: pageProfileBase<pageProfilePlaylists> = try await self.requestGwLight("deezer.pageProfile", body: [
            "nb": 10000,
            "tab": "playlists",
            "user_id": "\(uid)"
        ])
        
        let playlists = try playlistsRes.TAB.playlists.data.map { try DeezerPlaylist.fromFragmentPlaylistResponse($0) }
        
        return playlists
        
    }
    
}
