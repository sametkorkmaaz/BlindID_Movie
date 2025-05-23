//
//  BlindAnimationView.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 23.05.2025.
//

import SwiftUI

struct BlindAnimationView: View {
    @State private var opacity: Double = 0.5

    var body: some View {
        ZStack {
            Color.darkBG.ignoresSafeArea()

            Text("BlindID")
                .font(FontManager.poppinsBold(size: 36))
                .foregroundColor(.blueB10)
                .opacity(opacity)
                .onAppear {
                    withAnimation(
                        Animation.easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true)
                    ) {
                        opacity = 1.0
                    }
                }
        }
    }
}

#Preview {
    BlindAnimationView()
}
