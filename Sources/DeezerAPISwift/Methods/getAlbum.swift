//
//  getAlbum.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/11/25.
//

extension DeezerAPI {
    public func getAlbum(_ id: Int) async throws -> DeezerAlbum {
        
        // Use gwLight request to get an album
        let albumRes: pageAlbumResponse = try await requestGwLight("deezer.pageAlbum", parameters: [:], body: [
            "alb_id": "\(id)",
            "tab": 0,
            "header": true
        ])
        
        return try DeezerAlbum.fromPageAlbumResponse(albumRes)
        
    }
}
