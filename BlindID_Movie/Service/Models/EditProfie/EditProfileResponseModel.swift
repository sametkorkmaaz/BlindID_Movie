//
//  EditProfileResponseModel.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import Foundation

struct EditProfileResponseModel: Decodable {
    let message: String?
    let user: EditedUser?
}

struct EditedUser: Decodable {
    let id: String?
    let name: String?
    let surname: String?
    let email: String?
}
