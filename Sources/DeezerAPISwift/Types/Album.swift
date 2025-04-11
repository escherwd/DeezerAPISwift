//
//  Album.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/11/25.
//


public struct DeezerAlbum: Decodable {
    
    let id: Int
    let title: String
    
    let pictureId: String
    let artistName: String
    let artistId: Int
    
    let numFans: Int
    let releaseDate: String
    
    let tracks: [DeezerTrack]?
    
    
}
