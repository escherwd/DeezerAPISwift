// The Swift Programming Language
// https://docs.swift.org/swift-book

// The basis for all methods relating to the Deezer API

open class DeezerAPI {

    // Create a new instance of the DeezerAPI with all data necessary to authorize requests
    // Deprecated; not really worth testing

//    init(
//        withArl arl: String,
//        andApiToken apiToken: String,
//        andSid sid: String,
//        andLang lang: String = "us"
//    ) {
//        self.arl = arl
//        self.apiToken = apiToken
//        self.sid = sid
//        self.lang = lang
//
//    }
    
    // Create a new instance of the DeezerAPI with only the ARL. The first request that needs auth will go through the flow, which may add some extra time.
    
    public init(withOnlyArl arl: String, andLang lang: String = "us") {
        self.arl = arl
        self.lang = lang
    }
    
    // Store the userId
    public var userId: Int?

    // The ARL is like a device token, it doesn't change often.
    let arl: String
    
    // The JWT is used for new types of requests; everything graphql
    var jwt: String?

    // These other ones do
    var apiToken: String?
    var sid: String?
    var playerToken: String?
    var licenseToken: String?

    // The language the API should use
    public var lang: String?

}
