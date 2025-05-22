//
//  RegisterResponseModel.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import Foundation

struct RegisterResponseModel: Decodable {
    let message: String?
    let token: String?
    let user: UserModel?
}
