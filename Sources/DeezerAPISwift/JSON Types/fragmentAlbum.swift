//
//  fragmentAlbum.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/14/25.
//

struct fragmentAlbum: Decodable {
    
    let ALB_ID: String
    let ALB_PICTURE: String
    let ALB_TITLE: String
//    let ART_ID: String
    let ART_NAME: String
//    let NB_FAN: Int
//    let NUMBER_TRACK: String
    let ORIGINAL_RELEASE_DATE: String
//    let DURATION: String
//    let LABEL_NAME: String
    let COPYRIGHT: String
    
    struct OBJ_SONGS: Decodable {
        
        let count: Int
        let total: Int
        let data: [fragmentTrack]
        
    }
    
    let SONGS: OBJ_SONGS
    
    let ARTISTS: [fragmentArtist]
    
}
