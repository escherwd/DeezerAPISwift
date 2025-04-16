//
//  Playlist.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/15/25.
//

public struct DeezerPlaylist: Decodable {

    let id: Int
    let title: String

    let checksum: String?

    let dateAdded: String?
    let dateModified: String?

    let description: String?
    let duration: Int?

    let isFavorite: Bool

    let lastSeen: Int?
    let numFans: Int
    let numSongs: Int

    let parentUserName: String
    let parentUserId: String
    let parentUserPicture: String

    let pictureType: DeezerPlaylistPictureType
    let playlistPicture: String

    let status: DeezerPlaylistStatus

    let collabKey: String?

    let tracks: [DeezerTrack]?

    enum DeezerPlaylistStatus: Int, Decodable {

        case `public` = 0
        case `private` = 1

    }

    enum DeezerPlaylistPictureType: String, Decodable {
        case `cover`  // Album Cover Collage
        case `playlist`  // Custom Uploaded Image
    }

    static func fromPagePlaylistResponse(_ response: pagePlaylistResponse)
        throws -> DeezerPlaylist
    {

        guard let id = Int(response.DATA.PLAYLIST_ID) else {
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
            lastSeen: response.DATA.LAST_SEEN,
            numFans: response.DATA.NB_FAN,
            numSongs: response.DATA.NB_SONG,
            parentUserName: response.DATA.PARENT_USERNAME,
            parentUserId: response.DATA.PARENT_USER_ID,
            parentUserPicture: response.DATA.PARENT_USER_PICTURE,
            pictureType: .init(rawValue: response.DATA.PICTURE_TYPE)!,
            playlistPicture: response.DATA.PLAYLIST_PICTURE,
            status: .init(rawValue: response.DATA.STATUS)!,
            collabKey: response.DATA.COLLAB_KEY,
            tracks: try response.SONGS.data.map { try DeezerTrack.fromFragmentTrack($0) }
        )

    }

}
