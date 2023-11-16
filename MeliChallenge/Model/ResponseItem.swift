//
//  ResponseItem.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 26/10/2023.
//

import Foundation

struct ResponseItem: Codable, Hashable {
    var currency_id: String
    var thumbnail: String
    var title: String
    var price: Double
    var id: String
}
