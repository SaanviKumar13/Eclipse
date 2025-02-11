//
//  BookSupport.swift
//  Eclipse
//
//  Created by user@87 on 28/10/24.
//

import Foundation

struct BookSupport {
    var id: String
    var user: User
    var book: Book
    var complaint: String
    var compensation: Double
}

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isFromUser: Bool

}
