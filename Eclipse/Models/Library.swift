//
//  Library.swift
//  Eclipse
//
//  Created by user@87 on 28/10/24.
//

import Foundation

struct Library {
    var booksByGenre: [String: [Book]]
    var statusLists: StatusLists
}

struct StatusLists {
    var wantToRead: [Book]
    var currentlyReading: [Book]
    var finished: [Book]
    var didNotFinish: [Book]
    var customLists: [ReadingList]
}

struct ReadingList {
    var id: String
    var name: String
    var books: [Book]
    var isPrivate: Bool
}

class List: Codable {
    var title: String
    var bookIDs: [String]
    var isPrivate: Bool

    init(title: String, bookIDs: [String], isPrivate: Bool) {
        self.title = title
        self.bookIDs = bookIDs
        self.isPrivate = isPrivate
    }

    // Add this method to convert the object to a dictionary
    func toDictionary() -> [String: Any] {
        return [
            "title": title,
            "bookIDs": bookIDs,
            "isPrivate": isPrivate
        ]
    }
}


