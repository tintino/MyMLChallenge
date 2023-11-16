//
//  AppErrors.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 13/11/2023.
//

import Foundation

enum MeliError: Error {
    case meliError(code: String)
    case incorrectURL
    case badSearchParam
}

extension MeliError: LocalizedError {
    public var errorDescription: String? {
        self.meliCode
    }
}

extension MeliError {
    public var meliCode: String? {
        switch self {
        case .incorrectURL:
            return "1000"
        case .badSearchParam:
            return "500"
        case .meliError(let code):
            return code            
        }
    }
}
