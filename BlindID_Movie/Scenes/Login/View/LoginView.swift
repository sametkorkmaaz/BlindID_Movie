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

    var body: some View {
        NavigationView {
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

                if viewModel.isSuccess {
                    Text("Başarılı")
                        .foregroundColor(.green)
                        .font(.caption)
                        .padding(.top, 4)
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.top, 4)
                }

                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
