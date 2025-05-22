//
//  RegisterRequestModel.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import Foundation

struct RegisterRequestModel: Encodable {
    let name: String
    let surname: String
    let email: String
    let password: String
}
