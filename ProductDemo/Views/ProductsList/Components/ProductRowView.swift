//
//  ProductRowView.swift
//  ProductDemo
//
//  Created by Ken Boreham on 9/3/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductRowView: View {
    let product: Product
    let addedToCart: Bool
    let addToCart: () -> Void
    let navigateToDetail: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                WebImage(url: product.thumbnail)
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.3))
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(product.title)
                        .font(.headline)
                    Text("$\(product.price, specifier: "%.2f")")
                        .font(.subheadline)
                }
            }
            HStack {
                Spacer(minLength: 150)
                AddToCartButton(addedToCart: addedToCart, addToCart: addToCart)
            }
        }
        .padding([.bottom, .trailing], 4)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
        .padding(.all, 8)
        .contentShape(Rectangle()) // Make entire row tappable
        .onTapGesture {
            navigateToDetail()
        }
    }
}


#Preview {
    return ProductRowView(product: Product.example, addedToCart: false, addToCart: {}, navigateToDetail: {})
        .fullScreenBackground(imageName: "background")
}
