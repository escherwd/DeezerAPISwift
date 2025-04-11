//
//  Track.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/11/25.
//

public struct DeezerTrack: Decodable {
    
    let title: String
    let id: Int
    
    let artistId: Int
    let artistName: String
    
    let albumId: Int
    let albumName: String
    
    let trackNum: Int
    let diskNum: Int
    let duration: Int
    
    let explicitContent: Bool
}
