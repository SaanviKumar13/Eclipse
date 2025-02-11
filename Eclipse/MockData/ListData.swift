//
//  ListData.swift
//  Eclipse
//
//  Created by user@87 on 02/11/24.
//

import Foundation

var wantToReadList: [String] = ["1", "4", "6"]
var currentlyReadingList: [String] = ["3"]
var finishedList: [String] = ["2", "5", "7"]
var didNotFinishList: [String] = ["8"]

let whodunitList: [String] = ["1", "6"]
let sciFiAdventuresList: [String] = ["2", "3"]
let historicalDramaList: [String] = ["5", "4"]

struct List {
    let title: String
    let bookIDs: [String]
    let isPrivate: Bool
}

var statusLists: [List] = [
    List(title: "Want To Read", bookIDs: wantToReadList, isPrivate: false),
    List(title: "Currently Reading", bookIDs: currentlyReadingList, isPrivate: true),
    List(title: "Finished", bookIDs: finishedList, isPrivate: false),
    List(title: "Did Not Finish", bookIDs: didNotFinishList, isPrivate: true)
]

var customLists: [String: List] = [
    "Whodunit?": List(title: "Whodunit?", bookIDs: whodunitList, isPrivate: false),
    "Sci-Fi Adventures": List(title: "Sci-Fi Adventures", bookIDs: sciFiAdventuresList, isPrivate: true),
    "Historical Drama": List(title: "Historical Drama", bookIDs: historicalDramaList, isPrivate: false)
]

var recommendedLists: [RecommendedList] = [
    RecommendedList(
        title: "Italian Vacation Vibes",
        subtitle: "No need to book a flight- these books will transport you to Italy",
        books: [
            "9", // Beautiful Ruins
            "10", // One Italian Summer
            "11"  // Under the Tuscan Sun
        ]
    ),
    
    RecommendedList(
        title: "Romantic Reads",
        subtitle: "Heartfelt stories of love and relationships",
        books: [
            "2", // It Ends with Us
            "4", // Pride and Prejudice
            "9", // Beautiful Ruins
            "10", // One Italian Summer
            "7"  // The Great Gatsby
        ]
    ),
    
    RecommendedList(
        title: "Classic Literature",
        subtitle: "Timeless classics that have stood the test of time",
        books: [
            "3", // 1984
            "4", // Pride and Prejudice
            "8", // The Catcher in the Rye
            "5", // To Kill a Mockingbird
            "7"  // The Great Gatsby
        ]
    ),
    
    RecommendedList(
        title: "Fantasy & Adventure",
        subtitle: "Magical worlds and thrilling quests",
        books: [
            "13", // Harry Potter and the Goblet of Fire
            "14", // Percy Jackson
            "12", // Dark Matter
            "7",  // The Great Gatsby
            "8"   // The Catcher in the Rye
        ]
    ),
    
    RecommendedList(
        title: "Historical & Thought-Provoking",
        subtitle: "Books that inspire and challenge your views on history",
        books: [
            "16", // Killers of the Flower Moon
            "3",  // 1984
            "6",  // Where the Crawdads Sing
            "5",  // To Kill a Mockingbird
            "1"   // The Midnight Library
        ]
    )
]
