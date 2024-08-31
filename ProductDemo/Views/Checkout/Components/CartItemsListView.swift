//
//  CartItemsListView.swift
//  ProductDemo
//
//  Created by Ken Boreham on 9/3/24.
//

import SwiftUI

struct CartItemsListView: View {
    var cart: [Product]
    
    var body: some View {
        List {
            ForEach(cart) { product in
                HStack {
                    Text(product.title)
                    Spacer()
                    Text("$\(product.price, specifier: "%.2f")")
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    CartItemsListView(cart: [Product.example])
}
