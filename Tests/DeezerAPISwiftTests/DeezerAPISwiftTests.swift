import Testing
import Foundation
@testable import DeezerAPISwift

// Click on the target > "Edit Scheme" to add this value to your environment variables
fileprivate let deezerArl = ProcessInfo.processInfo.environment["DEEZER_TEST_ARL"]!


@Test func GetAlbum() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    let deezerApi = DeezerAPI(withOnlyArl: deezerArl)
    
    let album = try await deezerApi.getAlbum(705543991)
    
    #expect(album.id == 705543991)
    #expect(album.title == "Grand Voyage")
    #expect(album.tracks?.count == 12)
    
}

@Test func GetArtist() async throws {
    let deezerApi = DeezerAPI(withOnlyArl: deezerArl)
    
    let artist = try await deezerApi.getArtist(127257)
    
    #expect(artist.id == 127257)
    #expect(artist.name == "Tennis")
}

@Test func GetPlaylist() async throws {
    
    let deezerApi = DeezerAPI(withOnlyArl: deezerArl)
    
    let playlist = try await deezerApi.getPlaylist(1950224742)
    
    #expect(playlist.title == "Bedroom Electronic")
    
    
}

@Test func GetTracks() async throws {
    let deezerApi = DeezerAPI(withOnlyArl: deezerArl)
    
    let tracks = try await deezerApi.getTracks([ 1238251242, 870080482, 908917602 ])
    
    #expect(tracks.count == 3)
    #expect(tracks.first?.title == "Moving Men (feat. Mac DeMarco)")
}

@Test func GetHome() async throws {
    let deezerApi = DeezerAPI(withOnlyArl: deezerArl)
    
    let home = try await deezerApi.getHome()
    
    #expect(home.expiresAt > Date())
    #expect(home.sections.count > 0)
}

@Test func GetUserFavTracks() async throws {
    let deezerApi = DeezerAPI(withOnlyArl: deezerArl)
    
    let tracks = try await deezerApi.getUserFavTracks()
    
    
    #expect(tracks.0.count > 0)
}

@Test func GetUserFavAlbums() async throws {
    let deezerApi = DeezerAPI(withOnlyArl: deezerArl)
    
    let albums = try await deezerApi.getUserFavAlbums()
    
    #expect(albums.0.count > 0)
}

@Test func GetUserFavArtists() async throws {
    let deezerApi = DeezerAPI(withOnlyArl: deezerArl)
    
    let artists = try await deezerApi.getUserFavArtists()
    
    #expect(artists.0.count > 0)
}

@Test func GetUserFavPlaylists() async throws {
    let deezerApi = DeezerAPI(withOnlyArl: deezerArl)
    
    let playlists = try await deezerApi.getUserFavPlaylists()
    
    #expect(playlists.count > 0)
}

@Test func GetUserProfile() async throws {
    let deezerApi = DeezerAPI(withOnlyArl: deezerArl)
    
    let profile = try await deezerApi.getUserProfile()
    
    #expect(profile.id == deezerApi.userId)
}

@Test func GetTrackUrls() async throws {
    let deezerApi = DeezerAPI(withOnlyArl: deezerArl)
    
    let album = try await deezerApi.getAlbum(705543991)
    
    let track = album.tracks!.first!
    
    let media = try await deezerApi.getTrackUrls(forTrackToken: track.trackToken!, andTrackId: track.id)
    
    #expect(media.urls.count > 0)
}

@Test func StreamTrack() async throws {
    let deezerApi = DeezerAPI(withOnlyArl: deezerArl)
    
    let album = try await deezerApi.getAlbum(297946982)
    
    let track = album.tracks!.first!
    
    let media = try await deezerApi.getTrackUrls(forTrackToken: track.trackToken!, andTrackId: track.id)
    
    try await deezerApi.streamTrack(fromMedia: media)
    
//    let artist = try await deezerApi.getArtist(album.artists!.first!.id)
    
    #expect(media.urls.count > 0)
}

