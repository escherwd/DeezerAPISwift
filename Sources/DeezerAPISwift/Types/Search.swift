//
//  Search.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/21/25.
//

public struct DeezerSearch {

    public let query: String

    public let topResult: DeezerContentType?

    public let tracks: [DeezerTrack]
    public let albums: [DeezerAlbum]
    public let artists: [DeezerArtist]
    public let playlists: [DeezerPlaylist]

    // TODO: add profiles?
    static func fromApiResponse(
        _ response: apiInstantSearchResponse,
        andQuery query: String
    ) throws -> DeezerSearch {
        
        var topResult: DeezerContentType?
        
        if let best = response.instantSearch.bestResult {
            if (best.album != nil) {
                topResult = .album(try DeezerAlbum.fromApiSearchFragment(best.album!))
            } else if (best.artist != nil) {
                topResult = .artist(try DeezerArtist.fromApiSearchFragment(best.artist!))
            } else if (best.track != nil) {
                topResult = .track(try DeezerTrack.fromApiSearchFragment(best.track!))
            } else if (best.playlist != nil) {
                topResult = .playlist(try DeezerPlaylist.fromApiSearchFragment(best.playlist!))
            }
        }

        return DeezerSearch(
            query: query,
            topResult: topResult,
            tracks: try response.instantSearch.results.tracks.edges.map {
                try DeezerTrack.fromApiSearchFragment($0.node)
            },
            albums: try response.instantSearch.results.albums.edges.map {
                try DeezerAlbum.fromApiSearchFragment($0.node)
            },
            artists: try response.instantSearch.results.artists.edges.map {
                try DeezerArtist.fromApiSearchFragment($0.node)
            },
            playlists: try response.instantSearch.results.playlists.edges.map {
                try DeezerPlaylist.fromApiSearchFragment($0.node)
            }
        )

    }
}
