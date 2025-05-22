//
//  EditProfileView.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import SwiftUI

struct EditProfileView: View {
    @StateObject private var viewModel = EditProfileViewModel()

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
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blueB10)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal)

                if let success = viewModel.successMessage {
                    Text(success)
                        .foregroundColor(.green)
                        .font(.caption)
                        .padding(.top, 4)
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.top, 4)
                }

                Spacer()
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
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
                    .padding()
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.blueB10, lineWidth: 1)
                    )
            } else {
                TextField(title, text: $text)
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
