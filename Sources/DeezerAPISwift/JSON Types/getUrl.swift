//
//  getUrl.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/14/25.
//

struct getUrlResponse: Decodable {
    
    struct DATA_OBJ: Decodable {
        
        struct MEDIA_OBJ: Decodable {
            
            struct URL_OBJ: Decodable {
                
                let url: String
                let provider: String
            }
            
            let media_type: String
            let format: String
            let exp: Int
            
            let sources: [URL_OBJ]
            
            
        }
        
        let media: [MEDIA_OBJ]
        
    }
    
    let data: [DATA_OBJ]
    
}
