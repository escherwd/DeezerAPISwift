//
//  Crypto.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/14/25.
//

import CryptoKit
import Foundation

// The blowfish secret key - required for generating the track-specific keys
fileprivate let deezerBlowfishSecret: String = ProcessInfo.processInfo.environment["DEEZER_BLOWFISH_SECRET"]!

struct DeezerApiEncryption {
    
    // Generates a Blowfish key for decrypting tracks
    // Taken from the Deemix library
    
    static func generateBlowfishKey(trackId: Int) -> String {
        
        let trackIdStr = String(trackId)
        
        let SECRET = deezerBlowfishSecret.map({ $0.asciiValue! });
        
        let idMd5 = Insecure.MD5.hash(data: trackIdStr.data(using: .ascii)!)
        
        let chars = idMd5.compactMap({ String(format: "%02x", $0) }).joined().map({ $0.asciiValue! })
        var bfKey = ""
        
        for i in 0..<16 {
            let firstByte = chars[i]
            let secondByte = chars[i + 16]
            let thirdByte: UInt8 = SECRET[i]
            bfKey += String(UnicodeScalar(Int(firstByte) ^ Int(secondByte) ^ Int(thirdByte))!)
        }
        
       return bfKey
    }
    
}
