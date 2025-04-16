//
//  getListData.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/15/25.
//

extension DeezerAPI {
    
    public func getListData(_ trackIds: [Int]) async throws -> [DeezerTrack] {
        
        // Use gwLight request to get a track infos
        let listRes: pagePlaylistResponse = try await requestGwLight("deezer.pagePlaylist", parameters: [:], body: [
            "sng_ids": trackIds
        ])
        
        
        
    }
    
}
