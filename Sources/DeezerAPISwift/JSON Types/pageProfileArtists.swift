//
//  pageProfileAlbums.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/18/25.
//

struct pageProfileArtists: Decodable {
    
    struct ARTISTS_OBJ: Decodable {
        
        let checksum: String
        let count: Int
        let total: Int
        
        let data: [fragmentArtist]
        
    }
    
    let artists: ARTISTS_OBJ
    
}
