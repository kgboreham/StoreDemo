//
//  CartButton.swift
//  ProductDemo
//
//  Created by Ken Boreham on 9/3/24.
//

import SwiftUI

struct CartButton: View {
    @ObservedObject var viewModel: ProductViewModel
    @State var animateCart: Bool = false
    
    var body: some View {
        ZStack {
            NavigationLink(destination: CheckoutView(viewModel: viewModel)) {
                ZStack {
                    Image(systemName: "cart")
                        .scaleEffect(animateCart ? 2.0 : 1.0)
                        .opacity(animateCart ? 0.0 : 1.0)
                        .onChange(of: viewModel.animateBadge) { _, value in
                            if value {
                                withAnimation(.easeOut) {
                                    animateCart = true
                                }
                            } else {
                                animateCart = false
                            }
                        }
                    Image(systemName: viewModel.cart.count > 0 ? "cart.fill" : "cart")
                    if viewModel.cart.count > 0 {
                        Text("\(viewModel.cart.count)")
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(6)
                            .background(Color.red)
                            .clipShape(Circle())
                            .offset(x: 14, y: -14)
                            .scaleEffect(viewModel.animateBadge ? 1.2 : 1.0)
                            .animation(.spring(), value: viewModel.animateBadge)
                    }
                }
                Text("Checkout")
                    .padding(3)
            }
        }
        .foregroundColor(.white)
        .padding(4)
        .background(Color.darkGreen, in: RoundedRectangle(cornerRadius: 10))
        
    }
}

#Preview {
    let vm = ProductViewModel()
    vm.addToCart(Product.example)
    return CartButton(viewModel: vm)
}
