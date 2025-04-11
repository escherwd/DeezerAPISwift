//
//  pageAlbum.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/11/25.
//

struct pageAlbumResponse: Decodable {
    
    struct DATA: Decodable {
        let ALB_ID: String
        let ALB_PICTURE: String
        let ALB_TITLE: String
        let ART_ID: String
        let ART_NAME: String
        let NB_FAN: Int
        let NUMBER_TRACK: String
        let ORIGINAL_RELEASE_DATE: String
        let DURATION: String
    }
    
    struct SONGS: Decodable {
        let count: Int
        
        struct data: Decodable {
            let ALB_ID: String
            let ALB_PICTURE: String
            let ALB_TITLE: String
            let ART_ID: String
            let ART_NAME: String
            let ART_PICTURE: String
            let DURATION: String
            let DISK_NUMBER: String
            let EXPLICIT_LYRICS: String
            let SNG_TITLE: String
            let SNG_ID: String
            let TRACK_NUMBER: String
        }
        
        let data: [data]
    }
    
    let DATA: DATA
    let SONGS: SONGS
    
}
