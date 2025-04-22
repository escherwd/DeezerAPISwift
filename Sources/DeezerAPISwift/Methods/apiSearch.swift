//
//  apiSearch.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/21/25.
//



extension DeezerAPI {
    
    public func search(q: String) async throws -> DeezerSearch {
        
        if self.jwt == nil {
            try await self.refreshJwtTokensFromArl()
        }
        
        
        // Make the request
        let searchRes: apiInstantSearchResponse = try await self.requestApi(operationName: "SearchFull", query: DeezerGraphQLQueries.SearchFull, variables: [
            "firstGrid": 10,
            "firstList": 10,
            "query": q
        ])
        
        return try DeezerSearch.fromApiResponse(searchRes, andQuery: q)
        
    }
    
}
