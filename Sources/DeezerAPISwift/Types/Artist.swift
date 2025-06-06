//
//  Artist.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/11/25.
//

import Foundation

public struct DeezerArtist: Codable {


    public let id: Int
    public let name: String
    public let picture: String?

    public let numFans: Int?
    public let bio: String?

    public let topTracks: [DeezerTrack]?
    public let relatedArtists: [DeezerArtist]?

    public let albums: [DeezerAlbum]?

    public let dateFavorite: Date?

    public let relatedPlaylists: [DeezerPlaylist]?
    public let selectedPlaylists: [DeezerPlaylist]?

    static func fromPageArtistResponse(_ response: pageArtistResponse)
        throws -> DeezerArtist
    {

        guard let artistId = Int(response.DATA.ART_ID) else {
            throw DeezerApiError.invalidResponse
        }

        // Return a cleaned-up DeezerArtist object
        return DeezerArtist(
            id: artistId,
            name: response.DATA.ART_NAME,
            picture: response.DATA.ART_PICTURE,
            numFans: response.DATA.NB_FAN,
            bio: response.BIO,
            topTracks: try response.TOP?.data.map {
                try DeezerTrack.fromFragmentTrack($0)
            },
            relatedArtists: try response.RELATED_ARTISTS?.data.map {
                try DeezerArtist.fromFragmentArtistResponse($0)
            },
            albums: try response.ALBUMS?.data.map {
                try DeezerAlbum.fromFragmentAlbumResponse($0)
            },
            dateFavorite: nil,
            relatedPlaylists: try response.RELATED_PLAYLIST?.data.map {
                try DeezerPlaylist.fromFragmentPlaylistResponse($0)
            },
            selectedPlaylists: try response.SELECTED_PLAYLIST?.data.map {
                try DeezerPlaylist.fromFragmentPlaylistResponse($0)
            }
        )

    }

    static func fromFragmentArtistResponse(_ response: fragmentArtist) throws
        -> DeezerArtist
    {

        guard let artistId = Int(response.ART_ID) else {
            throw DeezerApiError.invalidResponse
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        return DeezerArtist(
            id: artistId,
            name: response.ART_NAME,
            picture: response.ART_PICTURE,
            numFans: response.NB_FAN,
            bio: nil,
            topTracks: nil,
            relatedArtists: nil,
            albums: nil,
            dateFavorite: response.DATE_FAVORITE != nil
                ? dateFormatter.date(from: response.DATE_FAVORITE!) : nil,
            relatedPlaylists: nil,
            selectedPlaylists: nil
        )

    }

    static func fromApiSearchFragment(_ response: apiSearchArtistFragment)
        throws -> DeezerArtist
    {

        return DeezerArtist(
            id: try response.id.toInt(),
            name: response.name,
            picture: try deezerCoverUrlToId(response.picture.large[0]),
            numFans: response.fansCount,
            bio: nil,
            topTracks: nil,
            relatedArtists: nil,
            albums: nil,
            dateFavorite: response.isFavorite ? Date() : nil,
            relatedPlaylists: nil,
            selectedPlaylists: nil
        )

    }

}
