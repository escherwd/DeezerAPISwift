//
//  getUserFavTracks.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/15/25.
//

import Foundation

extension DeezerAPI {

    public func getUserFavTracks() async throws -> [DeezerTrack] {

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

        var tracks: [DeezerTrack] = []

        for chunk in trackIds.data.chunks(ofCount: 500) {
            tracks.append(
                contentsOf: try await self.getTracks(
                    chunk.map { Int($0.SNG_ID)! },
                    favTimestamps: chunk.map(\.DATE_FAVORITE)
                )
            )
        }

        return tracks;

    }

}
