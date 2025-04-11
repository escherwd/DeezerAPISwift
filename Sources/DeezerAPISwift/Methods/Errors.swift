//
//  Errors.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/11/25.
//

enum DeezerApiError: Error {
    case invalidResponse
    case apiError
    case urlSessionError(Error)
}
