import Testing
import Foundation
@testable import DeezerAPISwift

// Click on the target > "Edit Scheme" to add this value to your environment variables
fileprivate let deezerArl = ProcessInfo.processInfo.environment["DEEZER_TEST_ARL"]!


@Test func GetAlbum() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    let deezerApi = DeezerAPI(withOnlyArl: deezerArl)
    
    let album = try await deezerApi.getAlbum(705543991)
    
    print(deezerApi.licenseToken ?? "no license token")
    
    print(album)
    
    #expect(album.id == 705543991)
    #expect(album.title == "Grand Voyage")
    #expect(album.tracks?.count == 12)
    
}

@Test func GetArtist() async throws {
    let deezerApi = DeezerAPI(withOnlyArl: deezerArl)
    
    let artist = try await deezerApi.getArtist(127257)
    
    print(artist)
    
    #expect(artist.id == 127257)
    #expect(artist.name == "Tennis")
}

@Test func GetPlaylist() async throws {
    
    let deezerApi = DeezerAPI(withOnlyArl: deezerArl)
    
    let playlist = try await deezerApi.getPlaylist(1950224742)
    
    print(playlist)
    
    #expect(playlist.title == "Bedroom Electronic")
    
    
}

@Test func GetTracks() async throws {
    let deezerApi = DeezerAPI(withOnlyArl: deezerArl)
    
    let tracks = try await deezerApi.getTracks([ 1238251242, 870080482, 908917602 ])
    
    print(tracks)
    
    #expect(tracks.count == 3)
    #expect(tracks.first?.title == "Moving Men (feat. Mac DeMarco)")
}

@Test func GetUserFavTracks() async throws {
    let deezerApi = DeezerAPI(withOnlyArl: deezerArl)
    
    let tracks = try await deezerApi.getUserFavTracks()
    
    print(tracks.0.map{ "\($0.title) - \($0.dateFavorite!)" }.joined(by: "\n"))
    
    #expect(tracks.0.count > 0)
}

@Test func GetUserFavAlbums() async throws {
    let deezerApi = DeezerAPI(withOnlyArl: deezerArl)
    
    let albums = try await deezerApi.getUserFavAlbums()
    
    print(albums.0.map{ "\($0.title) - \($0.dateFavorite!)" }.joined(by: "\n"))
    
    #expect(albums.0.count > 0)
}

@Test func GetUserFavArtists() async throws {
    let deezerApi = DeezerAPI(withOnlyArl: deezerArl)
    
    let artists = try await deezerApi.getUserFavArtists()
    
    print(artists.0.map{ "\($0.name) - \($0.dateFavorite!)" }.joined(by: "\n"))
    
    #expect(artists.0.count > 0)
}

@Test func GetUserFavPlaylists() async throws {
    let deezerApi = DeezerAPI(withOnlyArl: deezerArl)
    
    let playlists = try await deezerApi.getUserFavPlaylists()
    
    print(playlists.map{ "\($0.title) - \($0.parentUserName)" }.joined(by: "\n"))
    
    #expect(playlists.count > 0)
}

@Test func GetTrackUrls() async throws {
    let deezerApi = DeezerAPI(withOnlyArl: deezerArl)
    
    let album = try await deezerApi.getAlbum(705543991)
    
    let track = album.tracks!.first!
    
    print(track.id)
    
    let media = try await deezerApi.getTrackUrls(forTrackToken: track.trackToken!, andTrackId: track.id)
    
    print(media)
    
    #expect(media.urls.count > 0)
}

@Test func StreamTrack() async throws {
    let deezerApi = DeezerAPI(withOnlyArl: deezerArl)
    
    let album = try await deezerApi.getAlbum(297946982)
    
    let track = album.tracks!.first!
    
    let media = try await deezerApi.getTrackUrls(forTrackToken: track.trackToken!, andTrackId: track.id)
    
    try await deezerApi.streamTrack(fromMedia: media)
    
    let artist = try await deezerApi.getArtist(album.artists!.first!.id)
    print(artist)
    
    #expect(media.urls.count > 0)
}

