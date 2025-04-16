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

@Test func getTracks() async throws {
    let deezerApi = DeezerAPI(withOnlyArl: deezerArl)
    
    let tracks = try await deezerApi.getTracks([ 1238251242, 870080482, 908917602 ])
    
    print(tracks)
    
    #expect(tracks.count == 3)
    #expect(tracks.first?.title == "Moving Men (feat. Mac DeMarco)")
}

@Test func getUserFavTracks() async throws {
    let deerzerApi = DeezerAPI(withOnlyArl: deezerArl)
    
    let tracks = try await deerzerApi.getUserFavTracks()
    
    print(tracks.map{ "\($0.title) - \($0.dateFavorite!)" }.joined(by: "\n"))
    
    #expect(tracks.count > 0)
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
    
    let album = try await deezerApi.getAlbum(45740531)
    
    let track = album.tracks!.first!
    
    let media = try await deezerApi.getTrackUrls(forTrackToken: track.trackToken!, andTrackId: track.id)
    
    try await deezerApi.streamTrack(fromMedia: media)
    
    let artist = try await deezerApi.getArtist(album.artists.first!.id)
    print(artist)
    
    #expect(media.urls.count > 0)
}

