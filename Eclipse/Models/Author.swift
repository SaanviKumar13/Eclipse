//
//  Author.swift
//  Eclipse
//
//  Created by user@87 on 28/10/24.
//

import Foundation

struct Author: Identifiable {
    var id = UUID()
    var name: String
    var bio: String
    var image: String
    var books: [Book]
}
