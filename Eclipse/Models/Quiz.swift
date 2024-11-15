//
//  Quiz.swift
//  Eclipse
//
//  Created by user@87 on 15/11/24.
//

import Foundation

struct Quiz {
    let id: String
    let title: String
    let questions: [Question]
}

struct Question {
    let id: Int
    let questionText: String
    let options: [String]
    let isMultipleChoice: Bool
}
