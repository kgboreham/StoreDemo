//
//  CheckoutView.swift
//  ProductDemo
//
//  Created by Ken Boreham on 9/3/24.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var viewModel: ProductViewModel

    var body: some View {
        VStack {
            if viewModel.cart.isEmpty {
                EmptyCartView()
            } else {
                CartItemsListView(cart: viewModel.cart)
                BuyButton { viewModel.clearCart() }
            }
        }
        .fullScreenBackground(imageName: "background")
        .navigationTitle("Checkout")
    }
}

#Preview {
    let vm = ProductViewModel()
    vm.cart = [Product.example]
    return CheckoutView(viewModel: vm)
}
