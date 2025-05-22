//
//  BlindService.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import Foundation

class BlindService {
    func registerUser(_ request: RegisterRequestModel) async throws -> RegisterResponseModel {
        let response = try await NetworkManager.shared.request(
            endpoint: "/api/auth/register",
            method: .POST,
            body: request,
            responseModel: RegisterResponseModel.self
        )
        NetworkManager.shared.authToken = response.token
        return response
    }

    func loginUser(_ request: LoginRequestModel) async throws -> LoginResponseModel {
        let response = try await NetworkManager.shared.request(
            endpoint: "/api/auth/login",
            method: .POST,
            body: request,
            responseModel: LoginResponseModel.self
        )
        NetworkManager.shared.authToken = response.token
        return response
    }
    
    func fetchAllMovies() async throws -> [Movie] {
        try await NetworkManager.shared.request(
            endpoint: "/api/movies",
            method: .GET,
            body: Optional<String>.none,
            responseModel: [Movie].self
        )
    }
    
    func fetchMovieById(_ id: Int) async throws -> Movie {
        try await NetworkManager.shared.request(
            endpoint: "/api/movies/\(id)",
            method: .GET,
            body: Optional<String>.none,
            responseModel: Movie.self
        )
    }
    
    func fetchCurrentUser() async throws -> UserDataResponseModel {
        try await NetworkManager.shared.request(
            endpoint: "/api/auth/me",
            method: .GET,
            body: Optional<String>.none,
            responseModel: UserDataResponseModel.self
        )
    }
    
    func updateUserProfile(_ request: EditProfileRequestModel) async throws -> EditProfileResponseModel {
        try await NetworkManager.shared.request(
            endpoint: "/api/users/profile",
            method: .PUT,
            body: request,
            responseModel: EditProfileResponseModel.self
        )
    }
    
    func likeMovieById(_ id: Int) async throws -> MovieLikeResponseModel {
        try await NetworkManager.shared.request(
            endpoint: "/api/movies/like/\(id)",
            method: .POST,
            body: Optional<String>.none,
            responseModel: MovieLikeResponseModel.self)
    }
    
    func unLikeMovieById(_ id: Int) async throws -> MovieLikeResponseModel {
        try await NetworkManager.shared.request(
            endpoint: "/api/movies/unlike/\(id)",
            method: .POST,
            body: Optional<String>.none,
            responseModel: MovieLikeResponseModel.self)
    }
    
    func fetchLikedMovies() async throws -> [Movie] {
        try await NetworkManager.shared.request(
            endpoint: "/api/users/liked-movies",
            method: .GET,
            body: Optional<String>.none,
            responseModel: [Movie].self
        )
    }
}
