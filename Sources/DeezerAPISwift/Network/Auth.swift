//
//  Auth.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/11/25.
//

import Foundation

extension DeezerAPI {
    
    func refreshTokensFromArl() async throws {
        
        // Use the getUserData method to get a new apiToken, sid, and playerToken
        let userInfoRes: getUserDataResponse = try await self.requestGwLight("deezer.getUserData", ignoreCredCheck: true)
        
        self.apiToken = userInfoRes.checkForm
        self.sid = userInfoRes.SESSION_ID
        self.lang = userInfoRes.SETTING_LANG
        self.playerToken = userInfoRes.PLAYER_TOKEN
        
        self.userId = userInfoRes.USER.USER_ID
        
        self.licenseToken = userInfoRes.USER.OPTIONS.license_token
        
    }
    
    func refreshJwtTokensFromArl() async throws {
        
        let loginData = try await self.request("https://auth.deezer.com/login/arl?jo=p&rto=c&i=c")
        
        struct LoginRes: Decodable {
            let jwt: String
        }
        
        let logistRes: LoginRes = try JSONDecoder().decode(LoginRes.self, from: loginData)
        
        self.jwt = logistRes.jwt
        
        
    }
    
}
