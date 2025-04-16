//
//  getPlaylist.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/15/25.
//

extension DeezerAPI {
    
    public func getPlaylist(_ id: Int) async throws -> DeezerPlaylist {
        
        // Use gwLight request to get a playlist
        let playlistRes: pagePlaylistResponse = try await requestGwLight("deezer.pagePlaylist", parameters: [:], body: [
            "playlist_id": "\(id)",
            "header":true,
            "nb":10000,
            "tab": 0,
            "start": 0,
        ])
        
        return try DeezerPlaylist.fromPagePlaylistResponse(playlistRes)
        
    }
    
}
