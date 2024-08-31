//
//  ProductViewModel.swift
//  ProductDemo
//
//  Created by Ken Boreham on 9/3/24.
//

import Foundation
import SwiftUI
import Combine

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false
    @Published var hasMoreProducts: Bool = true
    @Published var cart: [Product] = []
    @Published var flyingItem: Product? = nil
    @Published var addedToCart: Set<Int> = []
    @Published var animateBadge = false
    @Published var selectedProductIndex: Int? = nil

    private var currentPage = 1
    private let pageSize = 10
    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchProducts()
    }

    func fetchProducts() {
        guard !isLoading, hasMoreProducts else { return }

        isLoading = true
        let urlString = "https://dummyjson.com/products/category/sports-accessories?limit=\(pageSize)&skip=\((currentPage - 1) * pageSize)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: ProductResponseData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    print("Error fetching products: \(error)")
                }
            }, receiveValue: { [weak self] response in
                self?.products.append(contentsOf: response.products)
                self?.hasMoreProducts = response.total != self?.products.count
                self?.currentPage += 1
            })
            .store(in: &cancellables)
    }

    func addToCart(_ product: Product) {
        guard !cart.contains(where: { $0.id == product.id }) else { return }
        
        addedToCart.insert(product.id)
        
        withAnimation {
            flyingItem = product
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.animateBadge = true
            self.flyingItem = nil
            self.cart.append(product)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.animateBadge = false
            }
        }
    }
    
    func clearCart() {
        cart.removeAll()
        addedToCart.removeAll()
    }
    
    func selectNextProduct() {
        guard let currentIndex = selectedProductIndex, currentIndex < products.count - 1 else { return }
        selectedProductIndex = currentIndex + 1
    }
    
    func selectPreviousProduct() {
        guard let currentIndex = selectedProductIndex, currentIndex > 0 else { return }
        selectedProductIndex = currentIndex - 1
    }
}
