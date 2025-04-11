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
        
        // Parse data types that need to be transformed
        guard let albumId = Int(albumRes.DATA.ALB_ID), let artistId = Int(albumRes.DATA.ART_ID) else {
            throw DeezerApiError.invalidResponse
        }
        
        // Organize the tracks
        let tracks = try albumRes.SONGS.data.map { song in
            
            guard let trackId = Int(song.SNG_ID), let artistId = Int(song.ART_ID), let albumId = Int(song.ALB_ID), let trackNum = Int(song.TRACK_NUMBER), let diskNum = Int(song.DISK_NUMBER), let dur = Int(song.DURATION) else {
                throw DeezerApiError.invalidResponse
            }
            
            return DeezerTrack(title: song.SNG_TITLE, id: trackId, artistId: artistId, artistName: song.ART_NAME, albumId: albumId, albumName: song.ALB_TITLE, trackNum: trackNum, diskNum: diskNum, duration: dur, explicitContent: song.EXPLICIT_LYRICS == "1")
        }
        
        // Return a cleaned-up DeezerAlbum object
        return DeezerAlbum(id: albumId, title: albumRes.DATA.ALB_TITLE, pictureId: albumRes.DATA.ALB_PICTURE, artistName: albumRes.DATA.ART_NAME, artistId: artistId, numFans: albumRes.DATA.NB_FAN, releaseDate: albumRes.DATA.ORIGINAL_RELEASE_DATE, tracks: tracks)
        
    }
}
