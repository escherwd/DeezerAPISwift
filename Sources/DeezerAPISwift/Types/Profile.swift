//
//  User.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/21/25.
//

public struct DeezerProfile: Codable {
    

    public let name: String
    public let id: Int

    public let picture: String

    public let topTracks: [DeezerTrack]?
    public let topAlbums: [DeezerAlbum]?
    public let topArtists: [DeezerArtist]?

    public let recentArtists: [DeezerArtist]?
    public let recentAlbums: [DeezerAlbum]?

    public let lovedTracksId: Int
    public let numFollowers: Int
    public let numFollowing: Int

    public let isPublic: Bool
    public let isFollowing: Bool

    static func fromPageProfileResponse(
        _ response: pageProfileBase<pageProfileHome>
    ) throws -> DeezerProfile {
        
        guard let user = response.DATA.USER else {
            throw DeezerApiError.invalidResponse
        }

        return DeezerProfile(
            name: user.DISPLAY_NAME,
            id: try user.USER_ID.toInt(),
            picture: user.USER_PICTURE,
            topTracks: try response.TAB.home.top_track.data.map {
                try DeezerTrack.fromFragmentTrack($0)
            },
            topAlbums: try response.TAB.home.top_album.data.map {
                try DeezerAlbum.fromFragmentAlbumResponseTiny($0)
            },
            topArtists: try response.TAB.home.top_artist.data.map {
                try DeezerArtist.fromFragmentArtistResponse($0)
            },
            recentArtists: try response.TAB.home.artists.data.map {
                try DeezerArtist.fromFragmentArtistResponse($0)
            },
            recentAlbums: try response.TAB.home.albums.data.map {
                try DeezerAlbum.fromFragmentAlbumResponseTiny($0)
            },
            lovedTracksId: try user.LOVEDTRACKS_ID.toInt(),
            numFollowers: response.DATA.NB_FOLLOWER,
            numFollowing: response.DATA.NB_FOLLOWING,
            isPublic: response.DATA.IS_PUBLIC,
            isFollowing: response.DATA.FOLLOWING
        )

    }

}
