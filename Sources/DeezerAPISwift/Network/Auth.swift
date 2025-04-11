//
//  Auth.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/11/25.
//

extension DeezerAPI {
    
    func refreshTokensFromArl() async throws {
        
        // Use the getUserData method to get a new apiToken, sid, and playerToken
        let userInfoRes: getUserDataResponse = try await self.requestGwLight("deezer.getUserData", ignoreCredCheck: true)
        
        self.apiToken = userInfoRes.checkForm
        self.sid = userInfoRes.SESSION_ID
        self.lang = userInfoRes.SETTING_LANG
        self.playerToken = userInfoRes.PLAYER_TOKEN
        
    }
    
}
