//
//  Library.swift
//  Eclipse
//
//  Created by user@87 on 28/10/24.
//

import Foundation
import FirebaseFirestore

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

struct StatusList {
    var category: String
    var bookIDs: [String]
    
    static func from(document: DocumentSnapshot, category: String) -> StatusList? {
        guard let data = document.data(), let bookIDs = data["bookIDs"] as? [String] else { return nil }
        return StatusList(category: category, bookIDs: bookIDs)
    }
}
struct List {
    let id: String
    let title: String
    let bookIDs: [String]
    let isPrivate: Bool
    let createdAt: Date

    static func from(document: DocumentSnapshot) -> List? {
        let data = document.data()
        guard let title = data?["title"] as? String,
              let bookIDs = data?["bookIDs"] as? [String],
              let isPrivate = data?["isPrivate"] as? Bool,
              let timestamp = data?["createdAt"] as? Timestamp else {
            print("Error parsing List from Firestore document: \(document.data() ?? [:])")
            return nil
        }
        return List(
            id: document.documentID,
            title: title,
            bookIDs: bookIDs,
            isPrivate: isPrivate,
            createdAt: timestamp.dateValue()
        )
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "title": title,
            "bookIDs": bookIDs,
            "isPrivate": isPrivate,
            "createdAt": Timestamp(date: createdAt) 
        ]
    }
}

