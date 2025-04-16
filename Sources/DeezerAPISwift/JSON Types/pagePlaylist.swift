//
//  pagePlaylist.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/15/25.
//

struct pagePlaylistResponse: Decodable {
    
    
    let CURATOR: Bool
    let SONGS: SONGS_OBJ
    let DATA: DATA_OBJ
    
    
    
    
    struct SONGS_OBJ: Decodable {
        
        let data: [fragmentTrack]
        
        let checksum: String
        let count: Int
        let total: Int
        
    }
    
    
    
    struct DATA_OBJ: Decodable {
        let CHECKSUM: String
        let DATE_ADD: String
        let DATE_MOD: String
        let DESCRIPTION: String
        let DURATION: Int
        let IS_FAVORITE: Bool
        let LAST_SEEN: Int
        let NB_FAN: Int
        let NB_SONG: Int
        let PARENT_USERNAME: String
        let PARENT_USER_ID: String
        let PARENT_USER_PICTURE: String
        let PICTURE_TYPE: String
        let PLAYLIST_ID: String
        let PLAYLIST_PICTURE: String
        let TITLE: String
        let STATUS: Int // 0 = public, 1 = private
        let COLLAB_KEY: String?
        
    }
    
    
    
}
