//
//  ProductDetail.swift
//  BlibliProject
//
//  Created by Srijan Kumar  on 23/07/22.
//

import Foundation

struct DataMain: Codable{
    let data: DataClass?
}

struct DataClass: Codable{
    let products: [Product]?
}

struct Product: Codable {
    let name: String?
    let price: Price?
    let images: [String]?
    let review: Review?
    var addedToCart: String = "false"

    enum CodingKeys: String, CodingKey {
        case name, price, images, review
        }
}

struct Price: Codable {
    let priceDisplay: String?
    let strikeThroughPriceDisplay: String?
    let discount, minPrice: Int?
    let offerPriceDisplay: String?
}

struct Review: Codable {
    let rating, count: Int?
    let absoluteRating: Double?
}
