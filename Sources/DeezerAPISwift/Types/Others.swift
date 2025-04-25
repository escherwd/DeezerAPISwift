//
//  Others.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/21/25.
//

public enum DeezerContentType: Codable {
    case track(DeezerTrack)
    case album(DeezerAlbum)
    case playlist(DeezerPlaylist)
    case artist(DeezerArtist)
}
