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

    let numFans: Int?
    let releaseDate: String

    let tracks: [DeezerTrack]?
    let numTracks: Int

    let copyright: String?
    let label: String?
    
    let artists: [DeezerArtist]

    // Convenience function for creating objects from Deezer JSON response
    static func fromPageAlbumResponse(_ response: pageAlbumResponse) throws
        -> DeezerAlbum
    {
        // Parse data types that need to be transformed
        guard let albumId = Int(response.DATA.ALB_ID),
            let artistId = Int(response.DATA.ART_ID),
              let numTracks = Int(response.DATA.NUMBER_TRACK)
        else {
            throw DeezerApiError.invalidResponse
        }

        // Return a cleaned-up DeezerAlbum object
        return DeezerAlbum(
            id: albumId,
            title: response.DATA.ALB_TITLE,
            pictureId: response.DATA.ALB_PICTURE,
            artistName: response.DATA.ART_NAME,
            artistId: artistId,
            numFans: response.DATA.NB_FAN,
            releaseDate: response.DATA.ORIGINAL_RELEASE_DATE,
            tracks: try response.SONGS.data.map { try DeezerTrack.fromFragmentTrack($0) },
            numTracks: numTracks,
            copyright: response.DATA.COPYRIGHT,
            label: response.DATA.LABEL_NAME,
            artists: try response.DATA.ARTISTS.map { try DeezerArtist.fromFragmentArtistResponse($0) }
        )
    }
    
    
    static func fromFragmentAlbumResponse(_ response: fragmentAlbum) throws -> DeezerAlbum {
        
        // Parse data types that need to be transformed
        guard let albumId = Int(response.ALB_ID)
            //let artistId = Int(response.ART_ID)
        else {
            throw DeezerApiError.invalidResponse
        }
        
        let artistId = 0

        // Return a cleaned-up DeezerAlbum object
        return DeezerAlbum(
            id: albumId,
            title: response.ALB_TITLE,
            pictureId: response.ALB_PICTURE,
            artistName: response.ART_NAME,
            artistId: artistId,
            numFans: nil,
            releaseDate: response.ORIGINAL_RELEASE_DATE,
            tracks: try response.SONGS.data.map { try DeezerTrack.fromFragmentTrack($0) },
            numTracks: response.SONGS.total,
            copyright: response.COPYRIGHT,
            label: nil,
            artists: try response.ARTISTS.map { try DeezerArtist.fromFragmentArtistResponse($0) }
        )
        
    }

}
