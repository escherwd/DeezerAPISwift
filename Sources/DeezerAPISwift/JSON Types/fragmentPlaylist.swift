//
//  fragmentPlaylist.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/18/25.
//

struct fragmentPlaylist: Decodable {
    
    let DATE_ADD: String
    let DATE_FAVORITE: String?
    
    let LAST_SEEN: String?
    
    let NB_SONG: Int
    let PARENT_USERNAME: String?
    let PARENT_USER_ID: String
    
    let PICTURE_TYPE: String
    let PLAYLIST_ID: String
    let PLAYLIST_PICTURE: String
    let TITLE: String
    let STATUS: Int // 0 = public, 1 = private
    
    
}
