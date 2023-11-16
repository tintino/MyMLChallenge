//
//  Logger+Extension.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 14/11/2023.
//

import Foundation
import OSLog

extension Logger {
    
    private static var subsystem = Bundle.main.bundleIdentifier!

    static func appLogger(category: String) -> Logger {
        return Logger(subsystem: subsystem, category: category)
    }
}

