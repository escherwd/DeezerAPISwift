//
//  Media.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/14/25.
//

public struct DeezerMedia: Decodable {
    
    public enum DeezerMediaFormat: String, Decodable, CaseIterable {
        case flac
        case mp3_320
        case mp3_128
        case mp3_64
        case mp3_misc
    }
    
    public let format: DeezerMediaFormat
    public let expires: Int
    public let urls: [String]
    
    public let trackId: Int
    
}
