//
//  EditProfileView.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import SwiftUI

struct EditProfileView: View {
    @StateObject private var viewModel = EditProfileViewModel()
    @State private var showErrorPopup = false
    @State private var initialName = ""
    @State private var initialSurname = ""
    @State private var initialEmail = ""

    var body: some View {
        ZStack {
            Color.darkBG.ignoresSafeArea()

            VStack(spacing: 16) {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)

                    Spacer()
                }
                .padding(.horizontal)

                VStack(spacing: 12) {
                    ProfileEditField(title: "Name", text: $viewModel.name)
                    ProfileEditField(title: "Surname", text: $viewModel.surname)
                    ProfileEditField(title: "Email", text: $viewModel.email)
                    ProfileEditField(title: "Password", text: $viewModel.password, isSecure: true)
                }
                .padding(.horizontal)

                Button("Save Changes") {
                    Task {
                        await viewModel.updateProfile()
                        if viewModel.errorMessage != nil {
                            showErrorPopup = true
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(isModified ? Color.blueB10 : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal)
                .disabled(!isModified)

                if let success = viewModel.successMessage {
                    Text(success)
                        .foregroundColor(.green)
                        .font(.caption)
                        .padding(.top, 4)
                }
                Spacer()
            }
            .onAppear {
                Task {
                    if let user = try? await BlindService().fetchCurrentUser() {
                        viewModel.name = user.name ?? ""
                        viewModel.surname = user.surname ?? ""
                        viewModel.email = user.email ?? ""

                        initialName = user.name ?? ""
                        initialSurname = user.surname ?? ""
                        initialEmail = user.email ?? ""
                        viewModel.password = ""
                    }
                }
            }

            if showErrorPopup {
                PopupView(isPresented: $showErrorPopup)
                    .transition(.opacity)
                    .zIndex(2)
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var isModified: Bool {
        viewModel.name != initialName ||
        viewModel.surname != initialSurname ||
        viewModel.email != initialEmail ||
        !viewModel.password.isEmpty
    }
}

struct ProfileEditField: View {
    let title: String
    @Binding var text: String
    var isSecure: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.grayG30)

            if isSecure {
                SecureField(title, text: $text)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.blueB10, lineWidth: 1)
                    )
            } else {
                TextField(title, text: $text)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.blueB10, lineWidth: 1)
                    )
            }
        }
    }
}

#Preview {
    EditProfileView()
}
