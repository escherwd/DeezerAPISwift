//
//  fragmentTrack.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/14/25.
//

struct fragmentTrack: Decodable {
    let ALB_ID: String
    let ALB_PICTURE: String
    let ALB_TITLE: String
    let ART_ID: String
    let ART_NAME: String
    let ART_PICTURE: String?
    let DURATION: String
    let DISK_NUMBER: String?
    let EXPLICIT_LYRICS: String?
    let SNG_TITLE: String
    let SNG_ID: String
    let TRACK_NUMBER: String?
    let TRACK_TOKEN: String?
    let TRACK_TOKEN_EXPIRE: Int?
    
    let ARTISTS: [fragmentArtist]
    
}
