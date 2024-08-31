//
//  SelectedProductView.swift
//  ProductDemo
//
//  Created by Ken Boreham on 9/3/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct SelectedProductView: View {
    var product: Product
    
    var body: some View {
        WebImage(url: product.thumbnail)
            .indicator(.activity)
            .frame(height: 300)
            .id("productImage\(product.id)")
        
        Text(product.title)
            .font(.largeTitle)
            .padding()
            .id("productTitle\(product.id)")
        
        Text(product.description)
            .padding()
            .id("productDescription\(product.id)")
    }
}

#Preview {
    SelectedProductView(product: .example)
}
