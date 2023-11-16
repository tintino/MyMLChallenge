//
//  UnitTestMockDataUtil.swift
//  MeliChallengeTests
//
//  Created by Martin Gonzalez Vega on 07/11/2023.
//

import Foundation

struct UnitTestMockDataUtil {
    
    // - MARK: Mock utils
    
    var validMockSearchItemIndex: Int? {
        for i in mockResponeSearchItems.indices {
            return i
        }
        return nil
    }
    
    public  var mockResponeSearchItems: [ResponseItem] {
        let mockImageUrl = "https://www.ninchcompany.com/wp-content/uploads/2019/07/ml-pack-galeria06.jpg"
        return [
            ResponseItem(currency_id: "ARS", thumbnail: mockImageUrl, title: "1",price: 1.0,id: "1"),
            ResponseItem(currency_id: "ARS", thumbnail: mockImageUrl, title: "2",price: 2.0,id: "2"),
            ResponseItem(currency_id: "ARS", thumbnail: mockImageUrl, title: "3",price: 3.0,id: "3"),
            ResponseItem(currency_id: "ARS", thumbnail: mockImageUrl, title: "4",price: 4.0, id: "4"),
            ResponseItem(currency_id: "ARS", thumbnail: mockImageUrl, title: "5",price: 5.0,id: "5"),
            ResponseItem(currency_id: "ARS", thumbnail: mockImageUrl, title: "6",price: 6.0,id: "6"),
            ResponseItem(currency_id: "ARS", thumbnail: mockImageUrl, title: "7",price: 7.0,id: "7"),
            ResponseItem(currency_id: "ARS", thumbnail: mockImageUrl, title: "8",price: 8.0,id: "8"),
            ResponseItem(currency_id: "ARS", thumbnail: mockImageUrl, title: "9",price: 9.0,id: "9"),
            ResponseItem(currency_id: "ARS", thumbnail: mockImageUrl, title: "10", price: 10.0,id: "10"),
            ResponseItem(currency_id: "ARS", thumbnail: mockImageUrl, title: "11", price: 11.0, id: "11")
        ]
    }
    
}
