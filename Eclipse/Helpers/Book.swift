//
//  Book.swift
//  Eclipse
//
//  Created by user@87 on 19/11/24.
//

import Foundation

func getBookByID(_ id: String) -> Book? {
    return mockBooks.first { $0.id == id }
}
