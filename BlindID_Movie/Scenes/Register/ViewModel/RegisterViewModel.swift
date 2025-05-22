//
//  RegisterViewModel.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import Foundation

@MainActor
class RegisterViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var successMessage: String?
    @Published var isSuccess: Bool = false

    let constants = RegisterConstants()

    func register() async {
        isLoading = true
        errorMessage = nil
        successMessage = nil

        let request = RegisterRequestModel(name: name, surname: surname, email: email, password: password)

        do {
            let response = try await BlindService().registerUser(request)
            successMessage = response.message
            isSuccess = true
        } catch {
            errorMessage = error.localizedDescription
            isSuccess = false
        }

        isLoading = false
    }
}
