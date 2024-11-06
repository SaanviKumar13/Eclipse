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
