//
//  Cookies.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/11/25.
//

extension DeezerAPI {
    
    func generateCookiesString() -> String {
        return "arl=\(self.arl); sid=\(self.sid ?? "")"
    }
    
}
