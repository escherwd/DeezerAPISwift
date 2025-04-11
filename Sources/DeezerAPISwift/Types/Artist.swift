//
//  Artist.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/11/25.
//

public struct DeezerArtist: Decodable {
    let id: Int
    let name: String
    let picture: String?
    
    let numFans: Int
    let bio: String?
}
