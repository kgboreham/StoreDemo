//
//  AddToCartButton.swift
//  ProductDemo
//
//  Created by Ken Boreham on 9/3/24.
//

import SwiftUI

struct AddToCartButton: View {
    var addedToCart: Bool
    var addToCart: () -> ()
    @Namespace private var animationNamespace
    
    var body: some View {
        Button(action: {
            addToCart()
        }) {
            HStack(spacing: 16) {
                if (addedToCart) {
                    Text("In cart")
                        .transition(.move(edge: .leading).combined(with: .opacity))
                    Image(systemName: "cart.fill")
                        .matchedGeometryEffect(id: "CART", in: animationNamespace)
                } else {
                    Image(systemName: "cart.badge.plus")
                        .matchedGeometryEffect(id: "CART", in: animationNamespace)
                    Text("Add to cart")
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                }
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
        }
        .disabled(addedToCart)
        .background(addedToCart ? Color.green : Color.darkGreen)
        .animation(.easeInOut, value: addedToCart)
        .cornerRadius(10)
        .padding()
    }
}

#Preview {
    AddToCartButton(addedToCart: false) {}
}
