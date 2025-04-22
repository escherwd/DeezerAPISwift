//
//  pageHome.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/21/25.
//

import Foundation

struct pageHomeReponse: Decodable {

    let title: String
    let version: String

    let expire: Int

    struct SECTION_OBJ: Decodable {

        let title: String
        let layout: String
        let module_id: String
        let group_id: String

        let items: [HOME_ITEM_WRAPPER]

        struct HOME_ITEM_WRAPPER: Decodable {

            let data: HOME_ITEM

            let title: String
            let subtitle: String?
            let item_id: String
            let target: String?
            
            let type: String

        }

        enum HOME_ITEM: Decodable {

            case album(fragmentAlbumTiny)
            case artist(fragmentArtist)
            case track(fragmentTrack)
            case playlist(fragmentPlaylist)
            case unsupported

            struct BASE: Decodable {

                let type: HOME_ITEM_TYPE

                enum HOME_ITEM_TYPE: String, Codable {
                    case album
                    case artist
                    case track
                    case playlist
                    case unsupported
                }

                enum CodingKeys: String, CodingKey {
                    case type = "__TYPE__"
                }

            }

            init(from decoder: any Decoder) throws {
                let baseContainer = try decoder.container(
                    keyedBy: BASE.CodingKeys.self
                )
                let type =
                    (try? baseContainer.decode(
                        BASE.HOME_ITEM_TYPE.self,
                        forKey: .type
                    )) ?? .unsupported

                let container = try decoder.singleValueContainer()

                switch type {
                case .album:
                    self = .album(try container.decode(fragmentAlbumTiny.self))
                case .artist:
                    self = .artist(try container.decode(fragmentArtist.self))
                case .track:
                    self = .track(try container.decode(fragmentTrack.self))
                case .playlist:
                    self = .playlist(
                        try container.decode(fragmentPlaylist.self)
                    )
                case .unsupported:
                    self = .unsupported
                }
            }

        }

    }

    let sections: [SECTION_OBJ]

}
