//
//  apiBase.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/21/25.
//

struct apiBaseResponse<T: Decodable>: Decodable {
    
    
    let data: T
    
    let errors: [API_ERROR]?
    
    struct API_ERROR: Decodable {
        let message: String
        let type: String
    }
    
    
}
