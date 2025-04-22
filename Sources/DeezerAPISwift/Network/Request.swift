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
        method: String = "POST",
        enableGzip: Bool = true
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
        if enableGzip {
            req.addValue("gzip", forHTTPHeaderField: "content-encoding")
        }
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Add entries to the body of the request
        if let body = body, method != "GET" {
            let jsonData = try JSONSerialization.data(
                withJSONObject: body,
                options: []
            )
            req.httpBody = jsonData
        }
        
        // If JWT is present, add that too
        if let jwt = self.jwt {
            print("adding jwt \(jwt)")
            req.addValue("Bearer \(jwt)", forHTTPHeaderField: "authorization")
        }

        // Execute Request
        // TODO: more explicit error handling
        let (data, _) = try await session.data(for: req)

        return data

    }

    func requestApi<T: Decodable>(
        operationName: String,
        query: String,
        variables: [String: Any],
        ignoreCredCheck: Bool = false
    ) async throws -> T {

        // Ensure credentials exist
        if (self.apiToken == nil || self.lang == nil)
            && ignoreCredCheck == false
        {
            try await self.refreshTokensFromArl()
        }

        // Request the data
        let data = try await self.request(
            "https://pipe.deezer.com/api",
            body: [
                "operationName": operationName,
                "variables": variables,
                "query": query,
            ],
            enableGzip: false // Gzip doesn't play nicely with graphql requests
        )
        
//        print(String(bytes: data, encoding: .utf8)!)
        
        // Attempt Decoding
        return try JSONDecoder().decode(
            apiBaseResponse<T>.self,
            from: data
        ).data

    }

    func requestGwLight<T: Decodable>(
        _ method: String,
        parameters: [String: Any]? = nil,
        body: [String: Any]? = nil,
        ignoreCredCheck: Bool = false,
        httpMethod: String = "POST"
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
            ].merging(body ?? [:], uniquingKeysWith: { c, _ in c }),
            method: httpMethod
        )

        // First it will try to serialize with an error
        if (try? JSONDecoder().decode(
            gwLightBaseWithError.self,
            from: data
        )) != nil {
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
