//
//  Request.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/11/25.
//

import Combine
import Foundation

extension DeezerAPI {

    func request(
        _ urlString: String,
        parameters: [String: Any]? = nil,
        body: [String: Any]? = nil,
        method: String = "POST"
    ) async throws -> Data {

        // Create a new URL session
        let session = URLSession(configuration: .default)

        // Create URL with parameters
        let url = URL(string: urlString)!.appending(
            queryItems: (parameters ?? [:]).map {
                param in URLQueryItem(name: param.key, value: "\(param.value)")
            }
        )

        // Create a request from the url
        var req = URLRequest(url: url)
        req.httpMethod = method

        // Set the cookies (for auth)
        req.httpShouldHandleCookies = true
        req.addValue(self.generateCookiesString(), forHTTPHeaderField: "Cookie")

        // Using gzip speeds up the request considerably
        req.addValue("gzip", forHTTPHeaderField: "content-encoding")
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Add entries to the body of the request
        if let body = body {
            let jsonData = try JSONSerialization.data(
                withJSONObject: body,
                options: []
            )
            req.httpBody = jsonData
        }

        // Execute Request
        // TODO: more explicit error handling
        let (data, _) = try await session.data(for: req)

        return data

    }

    func requestGwLight<T: Decodable>(
        _ method: String,
        parameters: [String: Any]? = nil,
        body: [String: Any]? = nil,
        ignoreCredCheck: Bool = false
    ) async throws -> T {

        // Ensure credentials exist
        if (self.apiToken == nil || self.lang == nil)
            && ignoreCredCheck == false
        {
            try await self.refreshTokensFromArl()
        }

        // Redirect to request function
        let data = try await self.request(
            "https://www.deezer.com/ajax/gw-light.php",
            parameters: [
                "method": method,
                "input": "3",
                "api_version": "1.0",
                "api_token": self.apiToken ?? "",
            ].merging(parameters ?? [:], uniquingKeysWith: { c, _ in c }),
            body: [
                "lang": self.lang ?? "us"
            ].merging(body ?? [:], uniquingKeysWith: { c, _ in c })
        )

        // First it will try to serialize with an error
        if let _ = try? JSONDecoder().decode(
            gwLightBaseWithError.self,
            from: data
        ) {
            //            print(method)
            //            print(err)
            //            print(self.apiToken)
            throw DeezerApiError.apiError
        }

        // Then it will try to serialize with the correct JSON structure
        return try JSONDecoder().decode(
            gwLightBase<T>.self,
            from: data
        ).results

    }

}
