//
//  FullScreenBackgroundViewModifier.swift
//  ProductDemo
//
//  Created by Ken Boreham on 9/3/24.
//

import SwiftUI

struct FullScreenBackground: ViewModifier {
    let imageName: String
    
    func body(content: Content) -> some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .rotationEffect(.degrees(-90))
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)

            content
        }
    }
}

extension View {
    func fullScreenBackground(imageName: String) -> some View {
        self.modifier(FullScreenBackground(imageName: imageName))
    }
}


#Preview {
    Color.blue
        .frame(width: 300, height: 100)
        .padding(24)
        .fullScreenBackground(imageName: "background")
}
