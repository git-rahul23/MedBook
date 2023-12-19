//
//  BookListingModel.swift
//  Medbook
//
//  Created by RAHUL RANA on 19/12/23.
//

import Foundation

struct BookListingModel: Codable {
    let docs: [Book]?
}

struct Book: Codable, Equatable {
    let title: String?
    let ratingsAverage: Double?
    let ratingsCount, coverI: Int?
    let authorName: [String]?

    enum CodingKeys: String, CodingKey {
        case title
        case ratingsAverage = "ratings_average"
        case ratingsCount = "ratings_count"
        case coverI = "cover_i"
        case authorName = "author_name"
    }
}
