//
//  Book.swift
//  Eclipse
//
//  Created by user@87 on 28/10/24.
//

import Foundation
import UIKit

struct Book {
    var id: String
    var title: String
    var author: Author
    var genre: String
    var description: String
    var coverImageURL: UIImage
    var tags: [Tag]
    var rating: Double
    var price: Double?
    var rentersNearby: Int
    var seriesInfo: SeriesInfo?
    var status: Status?
}

struct SeriesInfo {
    var seriesName: String
    var bookOrder: Int
}

struct Tag {
    var id: String
    var name: String
}

enum Status: String{
    case wantToRead = "Want to Read"
    case currentlyReading = "Currently Reading"
    case finished = "Finished"
    case didNotFinish = "Did Not Finish"
}
