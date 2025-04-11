import Testing
import Foundation
@testable import DeezerAPISwift

// Click on the target > "Edit Scheme" to add this value to your environment variables
fileprivate let deezerArl = ProcessInfo.processInfo.environment["DEEZER_TEST_ARL"]!


@Test func GetAlbum() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    let deezerApi = DeezerAPI(onlyArl: deezerArl)
    
    let album = try await deezerApi.getAlbum(705543991)
    
    #expect(album.id == 705543991)
    #expect(album.title == "Grand Voyage")
    #expect(album.tracks?.count == 12)
    
}

@Test func GetArtist() async throws {
    let deezerApi = DeezerAPI(onlyArl: deezerArl)
    
    let artist = try await deezerApi.getArtist(127257)
    
    #expect(artist.id == 127257)
    #expect(artist.name == "Tennis")
}
