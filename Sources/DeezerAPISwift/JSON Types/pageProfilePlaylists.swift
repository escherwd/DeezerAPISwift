//
//  pageProfileAlbums.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/18/25.
//

struct pageProfilePlaylists: Decodable {
    
    struct PLAYLISTS_OBJ: Decodable {
        
//        let checksum: String
        let count: Int
        let total: Int
        
        let data: [fragmentPlaylist]
        
    }
    
    let playlists: PLAYLISTS_OBJ
    
}
