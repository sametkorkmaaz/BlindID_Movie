//
//  EditProfileViewModel.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import Foundation

@MainActor
class EditProfileViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading = false
    @Published var successMessage: String?
    @Published var errorMessage: String?

    let service = BlindService()

    func updateProfile() async {
        isLoading = true
        errorMessage = nil
        successMessage = nil

        let request = EditProfileRequestModel(name: name, surname: surname, email: email, password: password)

        do {
            let response = try await service.updateUserProfile(request)
            successMessage = response.message
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
