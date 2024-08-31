//
//  Product.swift
//  ProductDemo
//
//  Created by Ken Boreham on 9/3/24.
//

import Foundation

struct ProductResponseData: Decodable {
    var products: [Product]
    var total: Int
    var skip: Int
    var limit: Int
}

struct Product: Decodable, Identifiable {
    var id: Int
    var title: String
    var description: String
    var price: Double
    var images: [URL]
    var thumbnail: URL
}

extension Product: Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}
