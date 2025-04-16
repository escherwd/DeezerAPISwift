//
//  pageAlbum.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/11/25.
//

struct pageAlbumResponse: Decodable {
    
    struct DATA_OBJ: Decodable {
        let ALB_ID: String
        let ALB_PICTURE: String
        let ALB_TITLE: String
        let ART_ID: String
        let ART_NAME: String
        let NB_FAN: Int
        let NUMBER_TRACK: String
        let ORIGINAL_RELEASE_DATE: String
        let DURATION: String
        let LABEL_NAME: String
        let COPYRIGHT: String
        let ARTISTS: [fragmentArtist]
    }
    
    struct SONGS_OBJ: Decodable {
        let count: Int
        
        let data: [fragmentTrack]
    }
    
    let DATA: DATA_OBJ
    let SONGS: SONGS_OBJ
    
}


