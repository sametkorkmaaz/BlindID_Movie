//
//  NetworkManager.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
}

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = URL(string: "https://moviatask.cerasus.app")!
    private init() {}

    func request<T: Decodable, U: Encodable>(
        endpoint: String,
        method: HTTPMethod = .GET,
        body: U?,
        responseModel: T.Type
    ) async throws -> T {
        guard let url = URL(string: endpoint, relativeTo: baseURL) else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if method != .GET, let body = body {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                throw NetworkError.decodingFailed(error)
            }
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse
            }
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.requestFailed(error)
        }
    }
}
