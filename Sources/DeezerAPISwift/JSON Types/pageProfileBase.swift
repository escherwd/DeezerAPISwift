//
//  pageProfileBase.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/18/25.
//

struct pageProfileBase<T: Decodable>: Decodable {
    
    

    let TAB: T
    let DATA: DATA_OBJ
    
    
    struct DATA_OBJ: Decodable {
        
        let FOLLOW: Bool
        let FOLLOWING: Bool
        let IS_PERSONNAL: Bool // I think they misspelled this?
        let IS_PUBLIC: Bool
        let NB_FOLLOWER: Int
        let NB_FOLLOWING: Int
        
        let USER: USER_OBJ?
        
        
        struct USER_OBJ: Decodable {
            
            let DISPLAY_NAME: String
            let LOVEDTRACKS_ID: String
            
            let USER_ID: String
            let USER_PICTURE: String
            
        }
        
    }
    
    

}
