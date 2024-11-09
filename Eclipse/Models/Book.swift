//
//  Book.swift
//  Eclipse
//
//  Created by user@87 on 28/10/24.
//

import Foundation

struct Book {
    var id: String?
    var title: String?
    var author: String?
    var genre: String?
    var description: String?
    var coverImageURL: URL?
    var tags: [String]?
    var rating: Double?
    var price: String?
    var rentersNearby: Int?
    var seriesInfo: SeriesInfo?
    let lender: String?
    let imageName: String
    let daysLeft: String?
        

}

struct SeriesInfo {
    var seriesName: String
    var bookOrder: Int
}

struct Tag {
    var id: String
    var name: String
}
