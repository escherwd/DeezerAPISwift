//
//  Others.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/21/25.
//

enum DeezerContentType: Decodable {
    case track(DeezerTrack)
    case album(DeezerAlbum)
    case playlist(DeezerPlaylist)
    case artist(DeezerArtist)
}
