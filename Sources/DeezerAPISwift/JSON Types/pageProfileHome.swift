//
//  pageProfileHome.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/21/25.
//

struct pageProfileHome: Decodable {
    
    struct HOME_OBJ: Decodable {
        
        // Usually 12+ tracks
        let top_track: fragmentCountedChildren<fragmentTrack>
        
        // Usually 12+ artists
        let top_artist: fragmentCountedChildren<fragmentArtist>
        let artists: fragmentCountedChildren<fragmentArtist>
        
        // Only 1 album
        let top_album: fragmentCountedChildren<fragmentAlbumTiny>
        let albums: fragmentCountedChildren<fragmentAlbumTiny>
        
        let playlists: fragmentCountedChildren<fragmentPlaylist>
        
        
    }
    
    let home: HOME_OBJ
    
}


struct fragmentCountedChildren<T: Decodable>: Decodable {
    
    let count: Int
    let total: Int
    
    let data: [T]
    
}
