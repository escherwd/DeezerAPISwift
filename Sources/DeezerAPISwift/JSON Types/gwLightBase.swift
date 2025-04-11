//
//  gwLightBase.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/11/25.
//

// The base of an unsuccesful gwLight request

struct gwLightBaseWithError: Decodable {
    
    let error: gwLightBaseErrors
    // 'results' also exists but is an empty array
}

// The base for every (succesful) response returned by a gwLight request

struct gwLightBase<T:Decodable>: Decodable {
    
    let results: T
    // 'error' also exists but is an empty array
    
}

// A running list of all the errors a gwLight Deezer request can produce

struct gwLightBaseErrors: Decodable {
    
    // Auth errors
    let VALID_TOKEN_REQUIRED: String?
    
    // Request malformed errors
    let GATEWAY_ERROR: String? // Happens when api_token is missing
    let MISSING_PARAMETER_ALB_ID: String?
    let MISSING_PARAMETER_LANG: String?
    
}
