//
//  BookData.swift
//  Eclipse
//
//  Created by user@87 on 29/10/24.
//

import Foundation

let mockBooks: [Book] = [
    Book(
        id: "1",
        title: "The Midnight Library",
        author: Author(
            name: "Matt Haig",
            bio: "Matt Haig is an English novelist and journalist. His work includes both fiction and non-fiction, often dealing with themes of mental health.",
            image: "https://example.com/matt_haig.jpg",
            books: []
        ),
        genre: "Fiction",
        description: "A novel about a woman who finds herself in a library with books representing different versions of her life.",
        coverImageURL: URL(string: "https://example.com/midnight_library.jpg"),
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
            name: "Colleen Hoover",
            bio: "Colleen Hoover is an American author known for her emotional romances and contemporary novels.",
            image: "https://example.com/colleen_hoover.jpg",
            books: []
        ),
        genre: "Romance",
        description: "A heart-wrenching story that tackles difficult themes and emotional challenges.",
        coverImageURL: URL(string: "https://example.com/it_ends_with_us.jpg"),
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
            name: "George Orwell",
            bio: "George Orwell was an English novelist and essayist, famous for his dystopian novels.",
            image: "https://example.com/george_orwell.jpg",
            books: []
        ),
        genre: "Dystopian",
        description: "A classic dystopian novel that delves into themes of government surveillance and totalitarianism.",
        coverImageURL: URL(string: "https://example.com/1984.jpg"),
        tags: [Tag(id: "3", name: "Classic"), Tag(id: "4", name: "Dystopian")],
        rating: 4.8,
        price: 15.99,
        rentersNearby: 7,
        seriesInfo: nil,
        status: .currentlyReading
    ),
    Book(
        id: "4",
        title: "Pride and Prejudice",
        author: Author(
            name: "Jane Austen",
            bio: "Jane Austen was an English novelist known for her insightful portrayals of early 19th-century British society.",
            image: "https://example.com/jane_austen.jpg",
            books: []
        ),
        genre: "Classic",
        description: "A story of love and social expectations in early 19th-century England.",
        coverImageURL: URL(string: "https://example.com/pride_prejudice.jpg"),
        tags: [Tag(id: "5", name: "Classic"), Tag(id: "6", name: "Romance")],
        rating: 4.7,
        price: 9.99,
        rentersNearby: 6,
        seriesInfo: nil,
        status: .wantToRead
    ),
    Book(
        id: "5",
        title: "To Kill a Mockingbird",
        author: Author(
            name: "Harper Lee",
            bio: "Harper Lee was an American novelist, best known for her novel 'To Kill a Mockingbird'.",
            image: "https://example.com/harper_lee.jpg",
            books: []
        ),
        genre: "Fiction",
        description: "A young girl's observations of racial injustice in the American South.",
        coverImageURL: URL(string: "https://example.com/to_kill_mockingbird.jpg"),
        tags: [Tag(id: "7", name: "Historical"), Tag(id: "8", name: "Social Issues")],
        rating: 4.9,
        price: 13.99,
        rentersNearby: 8,
        seriesInfo: nil,
        status: .finished
    ),
    Book(
        id: "6",
        title: "Where the Crawdads Sing",
        author: Author(
            name: "Delia Owens",
            bio: "Delia Owens is an American author and wildlife scientist, best known for her debut novel 'Where the Crawdads Sing'.",
            image: "https://example.com/delia_owens.jpg",
            books: []
        ),
        genre: "Mystery",
        description: "A coming-of-age murder mystery set in the marshes of North Carolina.",
        coverImageURL: URL(string: "https://example.com/crawdads_sing.jpg"),
        tags: [Tag(id: "9", name: "Mystery"), Tag(id: "10", name: "Coming of Age")],
        rating: 4.5,
        price: 11.99,
        rentersNearby: 4,
        seriesInfo: nil,
        status: .wantToRead
    ),
    Book(
        id: "7",
        title: "The Great Gatsby",
        author: Author(
            name: "F. Scott Fitzgerald",
            bio: "F. Scott Fitzgerald was an American novelist known for his depictions of the Jazz Age.",
            image: "https://example.com/f_scott_fitzgerald.jpg",
            books: []
        ),
        genre: "Classic",
        description: "A novel about the American dream and the dark side of wealth.",
        coverImageURL: URL(string: "https://example.com/great_gatsby.jpg"),
        tags: [Tag(id: "11", name: "Classic"), Tag(id: "12", name: "Tragedy")],
        rating: 4.4,
        price: 8.99,
        rentersNearby: 9,
        seriesInfo: nil,
        status: .finished
    ),
    Book(
        id: "8",
        title: "The Catcher in the Rye",
        author: Author(
            name: "J.D. Salinger",
            bio: "J.D. Salinger was an American writer known for his reclusive lifestyle and works about adolescent angst.",
            image: "https://example.com/jd_salinger.jpg",
            books: []
        ),
        genre: "Fiction",
        description: "A story about teenage rebellion and alienation.",
        coverImageURL: URL(string: "https://example.com/catcher_rye.jpg"),
        tags: [Tag(id: "13", name: "Classic"), Tag(id: "14", name: "Psychological")],
        rating: 4.2,
        price: 7.99,
        rentersNearby: 5,
        seriesInfo: nil,
        status: .didNotFinish
    )
]
