//
//  getHome.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/21/25.
//

extension DeezerAPI {

    public func getHome() async throws -> DeezerHome {

        let homeRes: pageHomeReponse = try await self.requestGwLight(
            "page.get",
            parameters: [
                "gateway_input": """
                {"PAGE":"home","VERSION":"2.5","SUPPORT":{"ads":["native"],"deeplink-list":["deeplink"],"event-card":["live-event"],"grid-preview-one":["album","artist","artistLineUp","channel","livestream","flow","playlist","radio","show","smarttracklist","track","user","video-link","external-link"],"grid-preview-two":["album","artist","artistLineUp","channel","livestream","flow","playlist","radio","show","smarttracklist","track","user","video-link","external-link"],"grid":["album","artist","artistLineUp","channel","livestream","flow","playlist","radio","show","smarttracklist","track","user","video-link","external-link"],"horizontal-grid":["album","artist","artistLineUp","channel","livestream","flow","playlist","radio","show","smarttracklist","track","user","video-link","external-link"],"horizontal-list":["track","song"],"item-highlight":["radio"],"large-card":["album","external-link","playlist","show","video-link"],"list":["episode"],"message":["call_onboarding"],"mini-banner":["external-link"],"slideshow":["album","artist","channel","external-link","flow","livestream","playlist","show","smarttracklist","user","video-link"],"small-horizontal-grid":["flow"],"long-card-horizontal-grid":["album","artist","artistLineUp","channel","livestream","flow","playlist","radio","show","smarttracklist","track","user","video-link","external-link"],"filterable-grid":["flow"]},"LANG":"us","OPTIONS":["deeplink_newsandentertainment","deeplink_subscribeoffer"]}
                """
            ],
            httpMethod: "GET"
        )

        return try DeezerHome.fromPageHomeResponse(homeRes)

    }

}
