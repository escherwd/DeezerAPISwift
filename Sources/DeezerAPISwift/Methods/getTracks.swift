//
//  getTracks.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/15/25.
//

extension DeezerAPI {

    public func getTracks(_ trackIds: [Int], favTimestamps: [Int]? = nil) async throws -> [DeezerTrack] {
        
        // The max amount of tracks is 500
        if trackIds.count > 500 {
            throw DeezerApiError.invalidRequest
        }
        
        // If favTimestamps are passed, there must be an equal amount
        if (favTimestamps?.count ?? trackIds.count != trackIds.count) {
            throw DeezerApiError.invalidRequest
        }

        // Use gwLight request to get a track infos
        let listRes: getListDataResponse = try await requestGwLight(
            "song.getListData",
            parameters: [:],
            body: [
                "sng_ids": trackIds
            ]
        )

        if listRes.count == 0 { return [] }
        
        return try listRes.data.enumerated().map { try DeezerTrack.fromFragmentTrack($0.element, dateFavorite: favTimestamps?[$0.offset]) }

    }

}
