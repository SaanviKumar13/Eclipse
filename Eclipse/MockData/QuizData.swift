//
//  QuizData.swift
//  Eclipse
//
//  Created by user@87 on 15/11/24.
//

import Foundation
import UIKit

let sampleQuiz = Quiz(
    id: "book-preferences",
    title: "Book Preferences Quiz",
    questions: [
        Question(
            id: 1,
            questionText: "What genre sounds good to you right now?",
            options: ["Mystery", "Romance", "Science Fiction", "Fantasy", "Non-Fiction"],
            isMultipleChoice: true
        ),
        Question(
            id: 2,
            questionText: "What are you in the mood for?",
            options: ["Adventurous", "Moving", "Dark", "Inspirational", "Feel-Good"],
            isMultipleChoice: true
        ),
        Question(
            id: 3,
            questionText: "Slow, Medium, or Fast-Paced Read?",
            options: ["Slow", "Medium", "Fast"],
            isMultipleChoice: false
        ),
        Question(
            id: 4,
            questionText: "Anything you'd like to avoid?",
            options: ["Violence", "Abuse", "Death", "Explicit Content", "Skip"],
            isMultipleChoice: true
        )
    ]
)

let sampleResults = [
    Book(
        id: "1",
        title: "The Midnight Library",
        author: Author(
            authorID: "1",
            name: "Matt Haig",
            bio: "Matt Haig is an English novelist and journalist. His work includes both fiction and non-fiction, often dealing with themes of mental health.",
            image: UIImage(named: "matt_haig")!
        ),
        genre: "Fiction",
        description: "A novel about a woman who finds herself in a library with books representing different versions of her life.",
        coverImageURL: UIImage(named:"midnight_library"),
        tags: [Tag(id: "1", name: "Inspirational")],
        rating: 4.3,
        price: 10.99,
        rentersNearby: 5,
        seriesInfo: nil,
        status: .wantToRead
    ),
    Book(
        id: "2",
        title: "It Ends with Us",
        author: Author(
            authorID: "2",
            name: "Colleen Hoover",
            bio: "Colleen Hoover is an American author known for her emotional romances and contemporary novels.",
            image: UIImage(named: "colleen_hoover")!
        ),
        genre: "Romance",
        description: "A heart-wrenching story that tackles difficult themes and emotional challenges.",
        coverImageURL: UIImage(named:"it_ends_with_us"),
        tags: [Tag(id: "2", name: "Romance")],
        rating: 4.6,
        price: 12.99,
        rentersNearby: 3,
        seriesInfo: nil,
        status: .finished
    ),
    Book(
        id: "3",
        title: "1984",
        author: Author(
            authorID: "3",
            name: "George Orwell",
            bio: "George Orwell was an English novelist and essayist, famous for his dystopian novels.",
            image: UIImage(named: "george_orwell")!
        ),
        genre: "Dystopian",
        description: "A classic dystopian novel that delves into themes of government surveillance and totalitarianism.",
        coverImageURL: UIImage(named:"1984"),
        tags: [Tag(id: "3", name: "Classic"), Tag(id: "4", name: "Dystopian")],
        rating: 4.8,
        price: 15.99,
        rentersNearby: 7,
        seriesInfo: nil,
        status: .currentlyReading
    )
]
