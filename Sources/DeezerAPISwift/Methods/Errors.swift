//
//  Errors.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/11/25.
//

enum DeezerApiError: Error {
    case invalidResponse
    case invalidRequest
    case apiError
    case invalidLicense
    case invalidDeezerSecret
    case mediaNotAvailable
    case urlSessionError(Error)
}
