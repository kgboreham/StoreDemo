//
//  EmptyCartView.swift
//  ProductDemo
//
//  Created by Ken Boreham on 9/3/24.
//

import SwiftUI

struct EmptyCartView: View {
    var body: some View {
        Text("Your cart is empty.")
            .font(.title)
            .padding()
    }
}

#Preview {
    EmptyCartView()
}
