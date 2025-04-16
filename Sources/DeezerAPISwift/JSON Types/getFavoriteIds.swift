//
//  getFavoriteIds.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/15/25.
//

struct getFavoriteIdsResponse: Decodable {
    
    let count: Int
    let total: Int
    let data: [FAV_OBJ]
    
    let checksum: String
    
    struct FAV_OBJ: Decodable {
        
        let DATE_FAVORITE: Int
        let SNG_ID: String
        
    }
    
}
