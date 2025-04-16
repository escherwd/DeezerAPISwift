//
//  Encryption.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/14/25.
//

import CryptoKit

struct DeezerApiEncryption {
    
    static func generateBlowfishKey(trackId: String) {
        let SECRET = "g4el58wc0zvf9na1";
        
        let idMd5 = Insecure.MD5.hash(data: trackId.data(using: .ascii)!)
        
        
        
//        const idMd5 = _md5(trackId.toString(), "ascii");
        
        let bfKey = "";
//        for i in 0..<16 {
//            bfKey += String(UnicodeScalar(Int(idMd5[i].hashValue) ^ Int(idMd5[i + 16].hashValue) ^ Int(SECRET.unicodeScalars.first!.value))!)
//        }
        
        
        
//        for (let i = 0; i < 16; i++) {
//            bfKey += String.fromCharCode(
//                idMd5.charCodeAt(i) ^ idMd5.charCodeAt(i + 16) ^ SECRET.charCodeAt(i)
//            );
//        }
//        return bfKey
    }
    
}
