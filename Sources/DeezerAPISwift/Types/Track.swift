//
//  Track.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/11/25.
//

public struct DeezerTrack: Codable {
    
    

    public let title: String
    public let id: Int

    public let artistId: Int
    public let artistName: String

    public let albumId: Int
    public let albumName: String

    public let trackNum: Int?
    public let diskNum: Int?
    public let duration: Int

    public let explicitContent: Bool

    public let trackToken: String?
    public let trackTokenExpires: Int?

    public let artists: [DeezerArtist]

    public let dateFavorite: Int?

    public let picture: String?

    static func fromFragmentTrack(
        _ response: fragmentTrack,
        dateFavorite: Int? = nil
    ) throws -> DeezerTrack {

        guard let trackId = Int(response.SNG_ID),
            let artistId = Int(response.ART_ID),
            let albumId = Int(response.ALB_ID),
            let dur = Int(response.DURATION)
        else {
            throw DeezerApiError.invalidResponse
        }

        return DeezerTrack(
            title: response.SNG_TITLE,
            id: trackId,
            artistId: artistId,
            artistName: response.ARTISTS.map(\.ART_NAME).joined(
                separator: ", "
            ),
            albumId: albumId,
            albumName: response.ALB_TITLE,
            trackNum: try response.TRACK_NUMBER?.toInt(),
            diskNum: try response.DISK_NUMBER?.toInt(),
            duration: dur,
            explicitContent: response.EXPLICIT_LYRICS == "1",
            trackToken: response.TRACK_TOKEN,
            trackTokenExpires: response.TRACK_TOKEN_EXPIRE,
            artists: try response.ARTISTS.map {
                try DeezerArtist.fromFragmentArtistResponse($0)
            },
            dateFavorite: dateFavorite,
            picture: response.ALB_PICTURE
        )

    }

    static func fromApiSearchFragment(_ response: apiSearchTrackFragment) throws
        -> DeezerTrack
    {

        return DeezerTrack(
            title: response.title,
            id: try response.id.toInt(),
            artistId: try response.contributors.edges.first!.node.id.toInt(),
            artistName: response.contributors.edges.first!.node.name,
            albumId: try response.album.id.toInt(),
            albumName: response.album.displayTitle,
            trackNum: nil,
            diskNum: nil,
            duration: response.duration,
            explicitContent: response.isExplicit,
            trackToken: nil,
            trackTokenExpires: nil,
            artists: [],
            dateFavorite: nil,
            picture: try deezerCoverUrlToId(response.album.cover.large.first)
        )

    }

}
