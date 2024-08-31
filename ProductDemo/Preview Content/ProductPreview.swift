//
//  ProductPreview.swift
//  ProductDemo
//
//  Created by Ken Boreham on 9/3/24.
//

import Foundation

extension ProductResponseData {
    static let example = {
        do {
            let url = Bundle.main.url(forResource: "products.json", withExtension: nil)!
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            let productResponse = try decoder.decode(ProductResponseData.self, from: data)
            return productResponse
        } catch {
            print(error)
            fatalError("Could not decode data")
        }
    }()
}

extension Product {
    static let allProducts = ProductResponseData.example.products
    static let example = allProducts[0]
}
