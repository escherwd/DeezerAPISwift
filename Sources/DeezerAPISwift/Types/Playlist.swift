//
//  Playlist.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/15/25.
//

import Foundation

public struct DeezerPlaylist: Codable {

    public let id: Int
    public let title: String

    public let checksum: String?

    public let dateAdded: String?
    public let dateModified: String?

    public let description: String?
    public let duration: Int?

    public let isFavorite: Bool

    public let lastSeen: Date?
    public let numFans: Int?
    public let numSongs: Int?

    public let parentUserName: String?
    public let parentUserId: Int
    public let parentUserPicture: String?

    public let pictureType: DeezerPlaylistPictureType
    public let playlistPicture: String?

    public let status: DeezerPlaylistStatus

    public let collabKey: String?

    public let tracks: [DeezerTrack]?

    public enum DeezerPlaylistStatus: Int, Codable {

        case `public` = 0
        case `private` = 1

    }

    public enum DeezerPlaylistPictureType: String, Codable {
        case `cover`  // Album Cover Collage
        case `playlist`  // Custom Uploaded Image
    }

    static func fromPagePlaylistResponse(_ response: pagePlaylistResponse)
        throws -> DeezerPlaylist
    {

        guard let id = Int(response.DATA.PLAYLIST_ID),
            let parentUserId = Int(response.DATA.PARENT_USER_ID)
        else {
            throw DeezerApiError.invalidResponse
        }

        return DeezerPlaylist(
            id: id,
            title: response.DATA.TITLE,
            checksum: response.DATA.CHECKSUM,
            dateAdded: response.DATA.DATE_ADD,
            dateModified: response.DATA.DATE_MOD,
            description: response.DATA.DESCRIPTION,
            duration: response.DATA.DURATION,
            isFavorite: response.DATA.IS_FAVORITE,
            lastSeen: Date(
                timeIntervalSince1970: TimeInterval(response.DATA.LAST_SEEN)
            ),
            numFans: response.DATA.NB_FAN,
            numSongs: response.DATA.NB_SONG,
            parentUserName: response.DATA.PARENT_USERNAME,
            parentUserId: parentUserId,
            parentUserPicture: response.DATA.PARENT_USER_PICTURE,
            pictureType: .init(rawValue: response.DATA.PICTURE_TYPE)!,
            playlistPicture: response.DATA.PLAYLIST_PICTURE,
            status: .init(rawValue: response.DATA.STATUS)!,
            collabKey: response.DATA.COLLAB_KEY,
            tracks: try response.SONGS.data.map {
                try DeezerTrack.fromFragmentTrack($0)
            }
        )

    }

    static func fromFragmentPlaylistResponse(_ response: fragmentPlaylist)
        throws -> DeezerPlaylist
    {

        guard let id = Int(response.PLAYLIST_ID),
            let parentUserId = Int(response.PARENT_USER_ID)
        else {
            throw DeezerApiError.invalidResponse
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        return DeezerPlaylist(
            id: id,
            title: response.TITLE,
            checksum: nil,
            dateAdded: response.DATE_ADD,
            dateModified: nil,
            description: nil,
            duration: nil,
            isFavorite: response.DATE_FAVORITE != nil,
            lastSeen: response.LAST_SEEN != nil
                ? dateFormatter.date(from: response.LAST_SEEN!) : nil,
            numFans: nil,
            numSongs: response.NB_SONG,
            parentUserName: response.PARENT_USERNAME,
            parentUserId: parentUserId,
            parentUserPicture: nil,
            pictureType: .init(rawValue: response.PICTURE_TYPE)!,
            playlistPicture: response.PLAYLIST_PICTURE,
            status: .init(rawValue: response.STATUS)!,
            collabKey: nil,
            tracks: nil
        )

    }

    static func fromApiSearchFragment(_ response: apiSearchPlaylistFragment)
        throws
        -> DeezerPlaylist
    {
        return DeezerPlaylist(
            id: try response.id.toInt(),
            title: response.title,
            checksum: nil,
            dateAdded: nil,
            dateModified: nil,
            description: nil,
            duration: nil,
            isFavorite: response.isFavorite,
            lastSeen: nil,
            numFans: response.fansCount,
            numSongs: response.estimatedTracksCount,
            parentUserName: response.owner?.name,
            parentUserId: try response.owner?.id.toInt() ?? -1,
            parentUserPicture: nil,
            pictureType: response.picture.large.first!.contains("playlist") ? .playlist : .cover,
            playlistPicture: try deezerCoverUrlToId(response.picture.large.first),
            status: .public,
            collabKey: nil,
            tracks: nil
        )
    }

}
