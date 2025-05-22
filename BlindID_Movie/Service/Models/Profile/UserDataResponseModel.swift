//
//  UserDataResponseModel.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import Foundation

struct UserDataResponseModel: Identifiable, Decodable {
    let id: String?
    let name: String?
    let surname: String?
    let email: String?
    let likedMovies: [Int]?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case surname
        case email
        case likedMovies
        case createdAt
        case updatedAt
    }
}
