//
//  getListData.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/15/25.
//

struct getListDataResponse: Decodable {
    
    let count: Int
    let total: Int
    let data: [fragmentTrack]
    
}
