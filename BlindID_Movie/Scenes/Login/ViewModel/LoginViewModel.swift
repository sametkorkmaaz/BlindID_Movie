//
//  LoginViewModel.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import Foundation
import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isSuccess: Bool = false

    let constants = LoginViewConstants()
    
    func login() async {
        isLoading = true
        errorMessage = nil
        do {
            let request = LoginRequestModel(email: email, password: password)
            let response = try await BlindService().loginUser(request)
            // TODO: Hata yönetimi popup gösterimi eklenebilir
            errorMessage = response.message
            isSuccess = true
        } catch {
            errorMessage = error.localizedDescription
            isSuccess = false
        }
        isLoading = false
    }
}
