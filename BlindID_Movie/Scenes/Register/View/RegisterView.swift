//
//  RegisterView.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @State private var isPasswordVisible = false
    @State private var showErrorPopup = false

    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                Image(viewModel.constants.blindImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 240, height: 120)
                    .padding(.top, 48)

                VStack(spacing: 8) {
                    Text(viewModel.constants.welcomeText)
                        .font(FontManager.poppinsBold(size: 28))

                    Text(viewModel.constants.registerMessageText)
                        .foregroundColor(.grayG30)
                        .font(FontManager.poppinsRegular(size: 14))
                }

                Group {
                    TextField(viewModel.constants.namePlaceholder, text: $viewModel.name)
                    TextField(viewModel.constants.surnamePlaceholder, text: $viewModel.surname)
                    TextField(viewModel.constants.emailPlaceholder, text: $viewModel.email)
                        .autocapitalization(.none)

                    HStack {
                        if isPasswordVisible {
                            TextField(viewModel.constants.passwordPlaceholder, text: $viewModel.password)
                        } else {
                            SecureField(viewModel.constants.passwordPlaceholder, text: $viewModel.password)
                        }
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? viewModel.constants.passwordEyeSlashIcon : viewModel.constants.passwordEyeIcon)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                Button {
                    Task {
                        await viewModel.register()
                        if viewModel.isSuccess {
                            isLoggedIn = true
                        } else if viewModel.errorMessage != nil {
                            showErrorPopup = true
                        }
                    }
                } label: {
                    Text(viewModel.constants.registerButtonText)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(30)
                }
                .disabled(viewModel.isLoading)

                if let success = viewModel.successMessage {
                    Text(success)
                        .foregroundColor(.green)
                        .font(FontManager.poppinsMedium(size: 12))
                }

                Spacer()
            }
            .padding()

            if showErrorPopup {
                PopupView(isPresented: $showErrorPopup)
                    .transition(.opacity)
                    .zIndex(2)
            }

            if viewModel.isLoading {
                ZStack {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()

                    BlindAnimationView()
                        .padding()
                        .background(Color.darkBG)
                        .cornerRadius(16)
                        .shadow(radius: 10)
                        .frame(width: 200, height: 150)
                }
                .transition(.opacity)
                .zIndex(1)
            }
        }
    }
}

#Preview {
    RegisterView()
}
