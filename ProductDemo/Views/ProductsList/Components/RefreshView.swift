//
//  RefreshView.swift
//  ProductDemo
//
//  Created by Ken Boreham on 9/3/24.
//

import SwiftUI
import Lottie

struct RefreshView<Content: View>: View {
    var content: Content
    var showsIndicators: Bool
    var loadingAnimation: String
    var onRefresh: () async -> ()
    
    @State var isRefreshing: Bool = false
    @State var contentOffset: CGFloat = 0
    @State var progress: CGFloat = 0
    
    init(showsIndicators: Bool = false, loadingAnimation: String, @ViewBuilder content: @escaping () -> Content, onRefresh: @escaping () async -> ()) {
        self.showsIndicators = showsIndicators
        self.loadingAnimation = loadingAnimation
        self.content = content()
        self.onRefresh = onRefresh
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: showsIndicators) {
            VStack(spacing: 0) {
                LottieView(animation: .named(loadingAnimation))
                    .playbackMode(isRefreshing ? .playing(.fromProgress(0, toProgress: 1, loopMode: .loop)) : .paused)
                    .scaleEffect(isRefreshing ? 1 : 0)
                    .frame(height: 150 * progress)
                    .animation(.easeInOut(duration: 0.25), value: isRefreshing)
                    .overlay {
                        VStack(spacing: 12) {
//                            LottieView(animation: .named("man-lifting-barbell"))
//                                .currentProgress(progress)
//                                .frame(height: 100)
                            
                            HStack {
                                Image(systemName: "arrow.down")
                                    .font(.caption.bold())
                                    .foregroundColor(Color.darkGreen)
                                    .rotationEffect(.init(degrees: progress * 180))
                                    .padding(8)
                                    .background(progress == 1 ? .green : .white, in: Circle())
                                if progress < 1 {
                                    Text("Pull To Refresh")
                                        .font(.caption.bold())
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .opacity(isRefreshing ? 0 : 1)
                        .animation(.easeInOut(duration: 0.25), value: isRefreshing)
                        
                    }
                    .opacity(progress)
                    .offset(y: contentOffset < 0 ? 0 : -contentOffset)
                    
                content
            }
            .overlay {
                GeometryReader { proxy in
                    let minY = proxy.frame(in: .named("SCROLL")).minY
                    Color.clear
                        .onChange(of: minY) { oldValue, value in
                            contentOffset = value
                            
                            if !isRefreshing {
                                progress = max(0, min(1, (value - 50) / 100))
                                if progress == 1 {
                                    isRefreshing = true
                                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                }
                            }
                        }
                }
            }
        }
        .coordinateSpace(name: "SCROLL")
        .onChange(of: isRefreshing) { oldValue, newValue in
            if newValue {
                Task {
                    await onRefresh()
                    withAnimation(.easeInOut(duration: 0.25)) {
                        progress = 0
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        isRefreshing = false
                    }
                }
            }
        }
    }
}

#Preview {
    RefreshView(loadingAnimation: "olympic-athlete") {
        Text("Content area")
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .background(Color.red)
        
    } onRefresh: {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
    }
    .background(Color(white: 0.2))
}
