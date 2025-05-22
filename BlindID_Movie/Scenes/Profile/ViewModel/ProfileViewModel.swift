//
//  ProfileViewModel.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import Foundation

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var userData: UserDataResponseModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func fetchUserData() async {
        isLoading = true
        do {
            let response = try await BlindService().fetchCurrentUser()
            self.userData = response
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
