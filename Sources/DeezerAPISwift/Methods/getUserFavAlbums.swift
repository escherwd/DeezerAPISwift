//
//  getUserFavAlbums.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/18/25.
//

extension DeezerAPI {
    
    public func getUserFavAlbums(forUserId: Int? = nil) async throws -> ([DeezerAlbum], String) {
        
        if (forUserId == nil) {
            try await self.refreshTokensFromArl()
        }
        
        guard let uid = forUserId ?? self.userId else {
            throw DeezerApiError.invalidRequest
        }
        
        let albumsRes: pageProfileBase<pageProfileAlbums> = try await self.requestGwLight("deezer.pageProfile", body: [
            "nb": 10000,
            "tab": "albums",
            "user_id": "\(uid)"
        ])
        
        let albums = try albumsRes.TAB.albums.data.map { try DeezerAlbum.fromFragmentAlbumResponseTiny($0) }
        
        return (albums, albumsRes.TAB.albums.checksum)
        
    }
    
}
