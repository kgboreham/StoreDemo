//
//  BuyButton.swift
//  ProductDemo
//
//  Created by Ken Boreham on 9/3/24.
//

import SwiftUI

struct BuyButton: View {
    var onPurchaseComplete: () -> ()
    @State private var isBuying = false
    
    var body: some View {
        Button(action: {
            isBuying.toggle()
            withAnimation(.easeInOut(duration: 1)) {
                if isBuying {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        onPurchaseComplete()
                        isBuying = false
                    }
                }
            }
        }) {
            ZStack {
                if isBuying {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text("Buy")
                        .bold()
                }
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.darkGreen)
            .cornerRadius(10)
        }
        .padding()
    }
}

#Preview {
    BuyButton { () }
}
