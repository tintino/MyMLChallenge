//
//  ResponseItemDetail.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 03/11/2023.
//

import Foundation

struct ResponseItemDetail: Codable {
    var id: String
    var price: Double
    var title: String
    var currency_id: String
    var pictures: [RespondeItemPicture]
}

struct RespondeItemPicture: Codable {
    var secure_url: String
}
