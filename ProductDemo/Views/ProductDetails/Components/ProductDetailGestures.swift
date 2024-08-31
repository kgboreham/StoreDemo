//
//  ProductDetailGestures.swift
//  ProductDemo
//
//  Created by Ken Boreham on 9/3/24.
//

import SwiftUI

class ProductDetailGestureHandler: ObservableObject {
    @Published var transition: AnyTransition = .opacity
    
    init() {
        transition = transition(for: .left)
    }
    
    func makeGesture(viewModel: ProductViewModel, presentationMode: Binding<PresentationMode>) -> some Gesture {
        return DragGesture()
            .onEnded { value in
                if value.translation.height > 100 {
                    // Dismiss if swipe down
                    presentationMode.wrappedValue.dismiss()
                } else if value.translation.width > 100 {
                    // Swipe right for the previous product
                    self.transition = self.transition(for: .right)
                    withAnimation(.easeInOut(duration: 0.5)) {
                        viewModel.selectPreviousProduct()
                    }
                } else if value.translation.width < -100 {
                    // Swipe left for the next product
                    self.transition = self.transition(for: .left)
                    withAnimation(.easeInOut(duration: 0.5)) {
                        viewModel.selectNextProduct()
                    }
                }
            }
    }

    enum TransitionDirection {
        case left, right, none
    }
    
    private func transition(for direction: TransitionDirection) -> AnyTransition {
        switch direction {
        case .left:
            return .asymmetric(
                insertion: .move(edge: .trailing),
                removal: .move(edge: .leading)
            ).combined(with: .opacity)
        case .right:
            return .asymmetric(
                insertion: .move(edge: .leading),
                removal: .move(edge: .trailing)
            ).combined(with: .opacity)
        case .none:
            return AnyTransition.opacity
        }
    }
}
