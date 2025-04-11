//
//  pageArtist.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/11/25.
//

struct pageArtistResponse: Decodable {
    
    // TODO: add bio with custom decoder method (sometimes obj sometimes bool)
    
    struct DATA: Decodable {
        
        let ART_ID: String
        let ART_NAME: String
        let ART_PICTURE: String?
        
        let NB_FAN: Int
        
    }
    
    let DATA: DATA
    
}
