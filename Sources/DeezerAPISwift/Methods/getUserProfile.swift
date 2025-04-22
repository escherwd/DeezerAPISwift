//
//  getUser.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/21/25.
//

extension DeezerAPI {
    
    public func getUserProfile(withId userId: Int? = nil) async throws -> DeezerProfile {
        
        if (userId == nil) {
            try await self.refreshTokensFromArl()
        }
        
        guard let uid = userId ?? self.userId else {
            throw DeezerApiError.invalidRequest
        }
        
        let profileReq: pageProfileBase<pageProfileHome> = try await self.requestGwLight("deezer.pageProfile", body: [
            "nb": 10000,
            "user_id": "\(uid)",
            "tab": "home"
        ])
        
        return try DeezerProfile.fromPageProfileResponse(profileReq)
        
        
    }
    
}
