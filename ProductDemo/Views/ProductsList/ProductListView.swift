//
//  ProductListView.swift
//  ProductDemo
//
//  Created by Ken Boreham on 9/3/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductListView: View {
    @StateObject private var viewModel = ProductViewModel()
    @State private var cartIconPosition: CGPoint = .zero
    
    init() {
        let navBar = UINavigationBarAppearance()
        navBar.configureWithTransparentBackground()
        navBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().scrollEdgeAppearance = navBar
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                RefreshView(loadingAnimation: "olympic-athlete") {
                    ForEach(Array(viewModel.products.enumerated()), id: \.element.id) { index, product in
                        ProductRowView(
                            product: product,
                            addedToCart: viewModel.addedToCart.contains(product.id),
                            addToCart: {
                                viewModel.addToCart(product)
                            },
                            navigateToDetail: {
                                navigateToDetail(index)
                            }
                        )
                        .onAppear {
                            if product == viewModel.products.last {
                                viewModel.fetchProducts()
                            }
                        }
                    }
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(.white)
                            .frame(maxWidth: .infinity)
                            .padding(16)
                    }
                    if !viewModel.hasMoreProducts {
                        Text("End of list")
                            .foregroundColor(.white)
                            .padding(16)
                    }
                } onRefresh: {
                    try? await Task.sleep(nanoseconds: 3_000_000_000) // Simulate loading
                    // viewModel.fetchProducts()
                }
                .background(Color.clear)
                .navigationTitle("Products")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem {
                        CartButton(viewModel: viewModel)
                    }
                }
            }
            .fullScreenBackground(imageName: "background")
        }
    }
    
    private func navigateToDetail(_ index: Int) {
        viewModel.selectedProductIndex = index
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let hostingController = UIHostingController(rootView: ProductDetailView(viewModel: viewModel))
            window.rootViewController?.present(hostingController, animated: true, completion: nil)
        }
    }
}

#Preview {
    ProductListView()
}
