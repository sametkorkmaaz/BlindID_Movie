//
//  LoginResponseModel.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import Foundation

struct LoginResponseModel: Decodable {
    let message: String?
    let token: String?
    let user: UserModel?
}

struct UserModel: Decodable {
    let id: String?
    let name: String?
    let surname: String?
    let email: String?
}
