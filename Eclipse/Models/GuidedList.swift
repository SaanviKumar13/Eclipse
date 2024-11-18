//
//  GuidedList.swift
//  Eclipse
//
//  Created by user@87 on 18/11/24.
//

import Foundation

struct GuidedList{
    let title: String
    let books: [String]
}

struct GuidedLists {
    let authorID: String
    let description: String
    let list: [GuidedList]
}
