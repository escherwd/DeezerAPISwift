//
//  Artist.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/11/25.
//

public struct DeezerArtist: Decodable {
    let id: Int
    let name: String
    let picture: String?

    let numFans: Int?
    let bio: String?

    let topTracks: [DeezerTrack]?
    let relatedArtists: [DeezerArtist]?

    let albums: [DeezerAlbum]?

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
        )

    }

    static func fromFragmentArtistResponse(_ response: fragmentArtist) throws
        -> DeezerArtist
    {

        guard let artistId = Int(response.ART_ID) else {
            throw DeezerApiError.invalidResponse
        }

        return DeezerArtist(
            id: artistId,
            name: response.ART_NAME,
            picture: response.ART_PICTURE,
            numFans: nil,
            bio: nil,
            topTracks: nil,
            relatedArtists: nil,
            albums: nil
        )

    }

}
