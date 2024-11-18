//
//  GuidedListData.swift
//  Eclipse
//
//  Created by user@87 on 18/11/24.
//

import Foundation

let guidedListsData: [GuidedLists] = [
    GuidedLists(
        authorID: "1",
        description: "If you enjoy emotional stories with a touch of humor, try these books.",
        list: [
            GuidedList(title: "Emotional & Humorous Reads", books: ["1", "2", "9"])
        ]
    ),
    GuidedLists(
        authorID: "2",
        description: "If you're into intense and emotional love stories, these books are for you.",
        list: [
            GuidedList(title: "Romantic & Emotional", books: ["3", "4", "10"]),
            GuidedList(title: "Heartfelt Love Stories", books: ["5", "8"])
        ]
    ),
    GuidedLists(
        authorID: "3",
        description: "Dystopian worlds with a critical view on society – here are the books I recommend.",
        list: [
            GuidedList(title: "Dystopian Classics", books: ["6", "7"])
        ]
    ),
    GuidedLists(
        authorID: "17",
        description: "Start your Discworld adventure with these must-reads.",
        list: [
            GuidedList(title: "Introduction to Discworld", books: ["21", "22","23","24"]),
            GuidedList(title: "The Death Series", books: ["23", "25"]),
            GuidedList(title: "The City Watch Series", books: ["24", "27"])
        ]
    ),
    GuidedLists(
        authorID: "18",
        description: "Psychological thrillers with deep twists and turns, try these.",
        list: [
            GuidedList(title: "Psychological Thrillers", books: ["28", "29"])
        ]
    )
]
