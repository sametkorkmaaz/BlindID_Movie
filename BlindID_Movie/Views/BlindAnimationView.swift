//
//  BlindAnimationView.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 23.05.2025.
//

import SwiftUI

struct BlindAnimationView: View {
    @State private var opacity: Double = 0.4
    @State private var scale: CGFloat = 0.95

    var body: some View {
        ZStack {
            Color.darkBG.ignoresSafeArea()

            VStack(spacing: 8) {
                Text("BlindID")
                    .font(FontManager.poppinsBold(size: 40))
                    .foregroundColor(.blueB10)
                    .scaleEffect(scale)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(
                            Animation.easeInOut(duration: 1)
                                .repeatForever(autoreverses: true)
                        ) {
                            opacity = 1.0
                            scale = 1.05
                        }
                    }

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blueB10))
            }
        }
    }
}

#Preview {
    BlindAnimationView()
}
