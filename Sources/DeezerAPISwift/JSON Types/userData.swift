//
//  userData.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/11/25.
//


struct getUserDataResponse: Decodable {
    
    let COUNTRY: String
    let OFFER_NAME: String
    
    // Used for playing tracks
    let PLAYER_TOKEN: String
    
    // Used for authorizing all requests (sid in cookies)
    let SESSION_ID: String
    
    let SETTING_LANG: String
    let URL_MEDIA: String
    
    // Used for authenticating all gwLight requests (this is auth_token)
    let checkForm: String
    
    // TODO: add user info from USER
    
}
