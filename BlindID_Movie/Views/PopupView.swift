//
//  PopupView.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 24.05.2025.
//

import SwiftUI

struct PopupView: View {
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }
            VStack(spacing: 12) {
                Image("errorPopupImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 64, height: 64)

                Text("Oops!")
                    .font(FontManager.poppinsSemiBold(size: 16))
                    .foregroundColor(.black)

                Text("Something went wrong, please try again")
                    .font(FontManager.poppinsMedium(size: 16))
                    .foregroundColor(.grayG30)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

            }
            .padding()
            .background(Color(.white))
            .cornerRadius(20)
            .shadow(radius: 10)
            .overlay(
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            isPresented = false
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .foregroundStyle(.grayG30)
                        }
                        .padding(8)

                        Spacer()
                    }
                }
            )
            .frame(maxWidth: 280)
        }
    }
}
