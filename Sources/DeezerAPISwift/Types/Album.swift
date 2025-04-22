//
//  Album.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/11/25.
//

import Foundation

public struct DeezerAlbum: Decodable {

    let id: Int
    let title: String

    let pictureId: String
    let artistName: String
    let artistId: Int

    let numFans: Int?
    let releaseDate: String

    let tracks: [DeezerTrack]?
    let numTracks: Int?

    let copyright: String?
    let label: String?

    let artists: [DeezerArtist]?

    let dateFavorite: Date?

    let completeness: CompletenessLevel

    // Convenience function for creating objects from Deezer JSON response
    static func fromPageAlbumResponse(_ response: pageAlbumResponse) throws
        -> DeezerAlbum
    {
        // Parse data types that need to be transformed
        guard let albumId = Int(response.DATA.ALB_ID),
            let artistId = Int(response.DATA.ART_ID),
            let numTracks = Int(response.DATA.NUMBER_TRACK)
        else {
            throw DeezerApiError.invalidResponse
        }

        // Return a cleaned-up DeezerAlbum object
        return DeezerAlbum(
            id: albumId,
            title: response.DATA.ALB_TITLE,
            pictureId: response.DATA.ALB_PICTURE,
            artistName: response.DATA.ART_NAME,
            artistId: artistId,
            numFans: response.DATA.NB_FAN,
            releaseDate: response.DATA.ORIGINAL_RELEASE_DATE,
            tracks: try response.SONGS.data.map {
                try DeezerTrack.fromFragmentTrack($0)
            },
            numTracks: numTracks,
            copyright: response.DATA.COPYRIGHT,
            label: response.DATA.LABEL_NAME,
            artists: try response.DATA.ARTISTS.map {
                try DeezerArtist.fromFragmentArtistResponse($0)
            },
            dateFavorite: nil,
            completeness: .complete
        )
    }

    static func fromFragmentAlbumResponse(_ response: fragmentAlbum) throws
        -> DeezerAlbum
    {

        // Parse data types that need to be transformed
        guard let albumId = Int(response.ALB_ID),
            let artistIdStr = response.ARTISTS.first?.ART_ID,
            let artistId = Int(artistIdStr)
        else {
            throw DeezerApiError.invalidResponse
        }

        // Return a cleaned-up DeezerAlbum object
        return DeezerAlbum(
            id: albumId,
            title: response.ALB_TITLE,
            pictureId: response.ALB_PICTURE,
            artistName: response.ART_NAME,
            artistId: artistId,
            numFans: nil,
            releaseDate: response.ORIGINAL_RELEASE_DATE,
            tracks: try response.SONGS.data.map {
                try DeezerTrack.fromFragmentTrack($0)
            },
            numTracks: response.SONGS.total,
            copyright: response.COPYRIGHT,
            label: nil,
            artists: try response.ARTISTS.map {
                try DeezerArtist.fromFragmentArtistResponse($0)
            },
            dateFavorite: nil,
            completeness: .mostlyComplete
        )

    }

    static func fromFragmentAlbumResponseTiny(_ response: fragmentAlbumTiny)
        throws -> DeezerAlbum
    {

        // Parse data types that need to be transformed
        guard let albumId = Int(response.ALB_ID),
            let artistId = Int(response.ART_ID)
        else {
            throw DeezerApiError.invalidResponse
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        return DeezerAlbum(
            id: albumId,
            title: response.ALB_TITLE,
            pictureId: response.ALB_PICTURE,
            artistName: response.ART_NAME,
            artistId: artistId,
            numFans: nil,
            releaseDate: response.PHYSICAL_RELEASE_DATE,
            tracks: nil,
            numTracks: nil,
            copyright: nil,
            label: nil,
            artists: nil,
            dateFavorite: response.DATE_FAVORITE != nil
                ? dateFormatter.date(from: response.DATE_FAVORITE!) : nil,
            completeness: .incomplete
        )

    }

    static func fromApiSearchFragment(_ response: apiSearchAlbumFragment) throws -> DeezerAlbum {

        return DeezerAlbum(
            id: try response.id.toInt(),
            title: response.displayTitle,
            pictureId: try deezerCoverUrlToId(response.cover.large[0])!,
            artistName: response.contributors.edges.map(\.node.name).joined(separator: ", "),
            artistId: try response.contributors.edges.first!.node.id.toInt(),
            numFans: nil,
            releaseDate: response.releaseDateAlbum,
            tracks: nil,
            numTracks: response.tracksCount,
            copyright: nil,
            label: nil,
            artists: nil,
            dateFavorite: response.isFavorite ? Date() : nil,
            completeness: .incomplete
        )

    }

    enum CompletenessLevel: Int, Decodable {
        // This album was fetched directly from the pageAlbum request. All data available is present.
        case `complete` = 2

        // Num. fans missing, label missing. Otherwise totally complete
        case `mostlyComplete` = 1

        // Track list missing, artist array missing, num. fans missing. Likely fetched from a user like list.
        case `incomplete` = 0
    }

}
