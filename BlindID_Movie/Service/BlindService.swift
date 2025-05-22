//
//  BlindService.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import Foundation

class BlindService {
    func registerUser(_ request: RegisterRequestModel) async throws -> RegisterResponseModel {
        try await NetworkManager.shared.request(
            endpoint: "/api/auth/register",
            method: .POST,
            body: request,
            responseModel: RegisterResponseModel.self
        )
    }

    func loginUser(_ request: LoginRequestModel) async throws -> LoginResponseModel {
        try await NetworkManager.shared.request(
            endpoint: "/api/auth/login",
            method: .POST,
            body: request,
            responseModel: LoginResponseModel.self
        )
    }
}
