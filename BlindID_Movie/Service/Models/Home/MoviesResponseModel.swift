//
//  MoviesResponseModel.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import Foundation

struct Movie: Identifiable, Decodable {
    let id: Int?
    let title: String?
    let year: Int?
    let rating: Double?
    let actors: [String]?
    let category: String?
    let poster_url: String?
    let description: String?
}
