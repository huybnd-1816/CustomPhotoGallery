//
//  BaseError.swift
//  CustomPhotoGallery
//
//  Created by nguyen.duc.huyb on 6/20/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

enum ErrorMessages: String {
    case networkError = "The internet got lost. Please try again!"
    case unexpectedError = "The system has an unexpected error. Please try again!"
    case apiFailure = "The API Request has failure. Please try again!"
}

enum BaseError: Error {
    case networkError
    case httpError(httpCode: Int)
    case unexpectedError
    case apiFailure
    
    var errorMessage: String? {
        switch self {
        case .networkError:
            return ErrorMessages.networkError.rawValue
        case .httpError(let code):
            return getHttpErrorMessage(httpCode: code)
        case .apiFailure:
            return ErrorMessages.apiFailure.rawValue
        default:
            return ErrorMessages.unexpectedError.rawValue
        }
    }
    
    private func getHttpErrorMessage(httpCode: Int) -> String? {
        if httpCode >= 300 && httpCode <= 308 {
            // Redirection
            return "It was transferred to a different URL. I'm sorry for causing you trouble"
        }
        if httpCode >= 400 && httpCode <= 451 {
            // Client error
            return "An error occurred on the application side. Please try again later!"
        }
        if httpCode >= 500 && httpCode <= 511 {
            // Server error
            return "A server error occurred. Please try again later!"
        }
        // Unofficial error
        return "An error occurred. Please try again later!"
    }
}
