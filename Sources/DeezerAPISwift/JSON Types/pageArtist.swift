//
//  pageArtist.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/11/25.
//

struct pageArtistResponse: Decodable {

    // TODO: add bio with custom decoder method (sometimes obj sometimes bool)
    
    let BIO: String?
    
    struct BIO_OBJ: Decodable {
        let BIO: String
        let RESUME: String
        let SOURCE: String
    }
    
    enum CodingKeys: CodingKey {
        case BIO
        case DATA
        case TOP
        case ALBUMS
        case RELATED_ARTISTS
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.DATA = try container.decode(pageArtistResponse.DATA_OBJ.self, forKey: .DATA)
        self.TOP = try container.decode(pageArtistResponse.TOP_OBJ?.self, forKey: .TOP)
        self.ALBUMS = try container.decode(pageArtistResponse.ALBUMS_OBJ?.self, forKey: .ALBUMS)
        self.RELATED_ARTISTS = try container.decode(pageArtistResponse.RELATED_ARTISTS_OBJ?.self, forKey: .RELATED_ARTISTS)
        
        // Decode the Bio into a BIO_OBJ and take either the BIO or RESUME from it
        let maybeBio = try? container.decodeIfPresent(
            BIO_OBJ.self,
            forKey: pageArtistResponse.CodingKeys.BIO
        )

        if (maybeBio?.BIO.isEmpty ?? true) == false {
            self.BIO = maybeBio?.BIO
        } else if (maybeBio?.RESUME.isEmpty ?? true) == false {
            self.BIO = maybeBio?.RESUME
        } else {
            self.BIO = nil
        }
    }
    

    struct DATA_OBJ: Decodable {

        

        let ART_ID: String
        let ART_NAME: String
        let ART_PICTURE: String?

        let NB_FAN: Int

    }

    let DATA: DATA_OBJ
    
    
    struct TOP_OBJ: Decodable {
        
        let count: Int
        let total: Int
        
        let data: [fragmentTrack]
        
    }
    
    let TOP: TOP_OBJ?
    
    
    struct ALBUMS_OBJ: Decodable {
        
        let count: Int
        let total: Int
        
        let data: [fragmentAlbum]
    }
    
    let ALBUMS: ALBUMS_OBJ?
    
    struct RELATED_ARTISTS_OBJ: Decodable {
        
        let count: Int
        let total: Int
        
        let data: [fragmentArtist]
    }
    
    let RELATED_ARTISTS: RELATED_ARTISTS_OBJ?

}
