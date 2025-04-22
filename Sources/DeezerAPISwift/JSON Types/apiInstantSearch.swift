//
//  apiSearch.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/21/25.
//

struct apiInstantSearchResponse: Decodable {
    
    let instantSearch: INSTANT_SEARCH_OBJ
    
    struct INSTANT_SEARCH_OBJ: Decodable {
        
        let results: RESULTS_OBJ
        let bestResult: BEST_RESULT_OBJ?
        
        struct RESULTS_OBJ: Decodable {
            
            let albums: apiSearchNodeCollectionOf<apiSearchAlbumFragment>
            let artists: apiSearchNodeCollectionOf<apiSearchArtistFragment>
            let tracks: apiSearchNodeCollectionOf<apiSearchTrackFragment>
            let playlists: apiSearchNodeCollectionOf<apiSearchPlaylistFragment>
            
        }
        
        struct BEST_RESULT_OBJ: Decodable {
            
            let artist: apiSearchArtistFragment?
            let track: apiSearchTrackFragment?
            let album: apiSearchAlbumFragment?
            let playlist: apiSearchPlaylistFragment?
            
        }
        
    }
    
}

struct apiSearchNodeCollectionOf<T: Decodable>: Decodable {
    
    let priority: Int?
    let edges: [NODE_OBJ]
    
    struct NODE_OBJ: Decodable {
        
        let node: T
    }
    
    
}

struct apiPictureFragment: Decodable {
    
    let id: String
    let large: [String]
    
}

struct apiContributorFragment: Decodable {
    
    let id: String
    let name: String
    
}

struct apiSearchAlbumFragment: Decodable {
    
    let displayTitle: String
    let id: String
    let isExplicitAlbum: Bool
    let isFavorite: Bool
    let releaseDateAlbum: String
    let tracksCount: Int
    
    let cover: apiPictureFragment
    
    let contributors: apiSearchNodeCollectionOf<apiContributorFragment>
    
    
}

struct apiSearchArtistFragment: Decodable {
    
    let fansCount: Int
    let id: String
    let isFavorite: Bool
    let name: String
    
    let picture: apiPictureFragment
    
}

struct apiSearchTrackFragment: Decodable {
    
    let title: String
    let isExplicit: Bool
    let id: String
    let duration: Int
    
    let contributors: apiSearchNodeCollectionOf<apiContributorFragment>
    
    let album: ALBUM_OBJ
    
    struct ALBUM_OBJ: Decodable {
        let id: String
        let displayTitle: String
        let cover: apiPictureFragment
    }
    
}

struct apiSearchPlaylistFragment: Decodable {
    
    let title: String
    let estimatedTracksCount: Int
    let fansCount: Int
    let id: String
    let isFavorite: Bool
    let picture: apiPictureFragment
    
    let owner: OWNER_OBJ?
    
    struct OWNER_OBJ: Decodable {
        
        let id: String
        let name: String
        
    }
    
}
