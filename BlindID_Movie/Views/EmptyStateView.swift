//
//  EmptyStateView.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 23.05.2025.
//

import SwiftUI

struct EmptyStateView: View {
    let messageText: String

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "film")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.blueB10)
                .padding(.top, 40)

            Text(messageText)
                .font(FontManager.poppinsMedium(size: 18))
                .foregroundColor(.orangeO50)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyStateView(messageText: "Deneme text")
}
