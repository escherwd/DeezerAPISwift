//
//  pageProfileAlbums.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/18/25.
//

struct pageProfileAlbums: Decodable {
    
    struct ALBUMS_OBJ: Decodable {
        
        let checksum: String
        let count: Int
        let total: Int
        
        let data: [fragmentAlbumTiny]
        
    }
    
    let albums: ALBUMS_OBJ
    
}
