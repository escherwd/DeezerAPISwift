//
//  getArtist.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/11/25.
//

extension DeezerAPI {
    public func getArtist(_ id: Int) async throws -> DeezerArtist {
        
        // Use gwLight request to get an album
        let albumRes: pageArtistResponse = try await requestGwLight("deezer.pageArtist", parameters: [:], body: [
            "art_id": "\(id)",
            "tab": 0,
        ])
        
        guard let artistId = Int(albumRes.DATA.ART_ID) else {
            throw DeezerApiError.invalidResponse
        }
        
        
        // Return a cleaned-up DeezerAlbum object
        return DeezerArtist(id: artistId, name: albumRes.DATA.ART_NAME, picture: albumRes.DATA.ART_PICTURE, numFans: albumRes.DATA.NB_FAN, bio: "none yet")
        
    }
}
