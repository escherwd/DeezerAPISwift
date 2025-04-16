//
//  getUserFavTracks.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/15/25.
//

import Foundation

extension DeezerAPI {
    
    public func getUserFavTrackIds() async throws -> [DeezerFavEntry] {
        
        // Get the IDs first
        let trackIds: getFavoriteIdsResponse = try await self.requestGwLight(
            "song.getFavoriteIds",
            body: [
                "nb": 10000,
                "start": 0,
            ]
        )
        
        // No tracks
        if trackIds.count == 0 { return [] }
        
        return trackIds.data.map {
            DeezerFavEntry(id: Int($0.SNG_ID)!, dateFavorite: $0.DATE_FAVORITE)
        }
        
        
    }

    
    public func getUserFavTracks() async throws -> [DeezerTrack] {

        // Get the track ids from the function above
        let trackIds = try await self.getUserFavTrackIds()

        var tracks: [DeezerTrack] = []

        for chunk in trackIds.chunks(ofCount: 500) {
            tracks.append(
                contentsOf: try await self.getTracks(
                    chunk.map(\.id),
                    favTimestamps: chunk.map(\.dateFavorite)
                )
            )
        }

        return tracks;

    }

}
