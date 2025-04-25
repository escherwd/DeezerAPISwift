//
//  Home.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/21/25.
//

import Foundation

public struct DeezerHome: Codable {

    enum SectionLayout: String, Codable {
        case horizontalGrid = "horizontal-grid"
        case horizontalList = "horizontal-list"
        case filterableGrid = "filterable-grid"
        case longCardHorizontalGrid = "long-card-horizontal-grid"
    }

    

    public struct Section: Codable {

        // TODO: Add support for enriched section titles

        let layout: SectionLayout
        let title: String
        let groupId: String

        let items: [DeezerContentType]

    }

    public let expiresAt: Date
    public let sections: [Section]

    static func fromPageHomeResponse(_ response: pageHomeReponse) throws
        -> DeezerHome
    {

        return .init(
            expiresAt: Date(
                timeIntervalSince1970: TimeInterval(response.expire)
            ),
            sections: try response.sections.map {
                Section(
                    layout: .init(rawValue: $0.layout)
                        ?? SectionLayout.horizontalGrid,
                    title: $0.title,
                    groupId: $0.group_id,
                    items: try $0.items.compactMap { item in
                        switch item.data {
                        case .album(let album):
                            return .album(
                                try DeezerAlbum.fromFragmentAlbumResponseTiny(
                                    album
                                )
                            )
                        case .artist(let artist):
                            return .artist(
                                try DeezerArtist.fromFragmentArtistResponse(
                                    artist
                                )
                            )
                        case .playlist(let playlist):
                            return .playlist(
                                try DeezerPlaylist.fromFragmentPlaylistResponse(
                                    playlist
                                )
                            )
                        case .track(let track):
                            return .track(
                                try DeezerTrack.fromFragmentTrack(track)
                            )
                        case .unsupported:
                            return nil
                        }
                    }
                )
            }
        )
    }

}
