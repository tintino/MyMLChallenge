//
//  AppConfiguration.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 08/11/2023.
//

import Foundation
import UIKit

// -  MARK: Endpoints

extension URL {
    
    static private let host = "https://api.mercadolibre.com"
    
    // - MARK: API
    
    static func productDetail(byId param: String) -> URL? {
        URL(string: "\(host)/items/\(param)")
    }
    
    static func searchItems(percentEncodedParam param: String) -> URL? {
        URL(string: "\(host)/sites/MLA/search?q=\(param)#json")
    }
}

// - MARK: App Fonts

extension UIFont {
    static func primary(ofSize size: CGFloat, andWeight weight: UIFont.Weight) -> UIFont {
        return systemFont(ofSize: size, weight: weight)
    }
}

// - MARK: Localized keys

extension String {
    static let searchOnMercadoLibre = "Search on Mercado Libre"
    static let userError = "Sorry something happened:"
    static let unknownError = "Unknown error"
    static let titleError = "Error"
    static let search = "Search"
    static let ok = "OK"
}
