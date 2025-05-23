//
//  LoginView.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @State private var isPasswordVisible = false
    @State private var showErrorPopup = false

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 24) {
                    Image(viewModel.constants.blindImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 240, height: 240)
                    
                    VStack(spacing: 8) {
                        Text(viewModel.constants.welcomeText)
                            .font(FontManager.poppinsBold(size: 28))
                        
                        Text(viewModel.constants.loginMessageTexxt)
                            .foregroundColor(.grayG30)
                            .font(FontManager.poppinsMedium(size: 16))
                    }
                    
                    HStack {
                        Image(systemName: viewModel.constants.emailTextfiledLogoName)
                            .foregroundColor(.grayG30)
                        TextField(viewModel.constants.emailTextfiledPlaceholder, text: $viewModel.email)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    HStack {
                        Image(systemName: viewModel.constants.passwordTextfieldLogoName)
                            .foregroundColor(.grayG30)
                        
                        if isPasswordVisible {
                            TextField(viewModel.constants.passwordTextfieldPlaceholder, text: $viewModel.password)
                        } else {
                            SecureField(viewModel.constants.passwordTextfieldPlaceholder, text: $viewModel.password)
                        }
                        
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? viewModel.constants.passwordTextFieldSlashEyeIconName : viewModel.constants.passwordTextFieldEyeIconName)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    HStack {
                        Spacer()
                        NavigationLink(destination: RegisterView()) {
                            Text(viewModel.constants.registerButtonText)
                                .font(.footnote)
                                .foregroundColor(.blue)
                        }
                    }
                    
                    Button {
                        Task {
                            await viewModel.login()
                            if viewModel.isSuccess {
                                isLoggedIn = true
                            } else if viewModel.errorMessage != nil {
                                showErrorPopup = true
                            }
                        }
                    } label: {
                        Text(viewModel.constants.loginButtonText)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.blueB10)
                            .cornerRadius(30)
                    }
                    .disabled(viewModel.isLoading)
                    Spacer()
                }
                .padding()
                
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
                
                if showErrorPopup {
                    PopupView(isPresented: $showErrorPopup)
                        .transition(.opacity)
                        .zIndex(2)
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
