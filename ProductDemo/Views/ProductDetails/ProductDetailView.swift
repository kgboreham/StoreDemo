//
//  ProductDetailView.swift
//  ProductDemo
//
//  Created by Ken Boreham on 9/3/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailView: View {
    @ObservedObject var viewModel: ProductViewModel
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var gestureHandler = ProductDetailGestureHandler()
    
    private var currentProduct: Product? {
        guard let selectedIndex = viewModel.selectedProductIndex, selectedIndex < viewModel.products.count else {
            return nil
        }
        return viewModel.products[selectedIndex]
    }
    
    var body: some View {
        ZStack {
            if let product = currentProduct {
                VStack {
                    SelectedProductView(product: product)
                        .id("Product\(product.id)")
                        .transition(gestureHandler.transition)
                    
                    Spacer()
                    
                    AddToCartButton(addedToCart: viewModel.cart.contains(product)) {
                        viewModel.addToCart(product)
                    }
                }
                .contentShape(Rectangle())
                .gesture(
                    gestureHandler
                        .makeGesture(viewModel: viewModel, presentationMode: presentationMode)
                )
                .navigationTitle(product.title)
                .navigationBarTitleDisplayMode(.inline)
            } else {
                Text("Product not found.")
            }
        }
    }
}

#Preview {
    let vm = ProductViewModel()
    vm.selectedProductIndex = 0
    return ProductDetailView(viewModel: vm)
}
