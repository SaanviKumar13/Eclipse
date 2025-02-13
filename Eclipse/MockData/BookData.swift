//
//  BookData.swift
//  Eclipse
//
//  Created by user@87 on 29/10/24.
//

import Foundation
import UIKit
let mockBooks: [Book] = [
    Book(
        id: "1",
        title: "The Midnight Library",
        author: authors[0],
        genre: "Fiction",
        description: "A novel about a woman who finds herself in a library with books representing different versions of her life.",
        coverImageURL: UIImage(named: "midnight_library")!,
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
        author: authors[1],
        genre: "Romance",
        description: "A heart-wrenching story that tackles difficult themes and emotional challenges.",
        coverImageURL: UIImage(named: "it_ends_with_us")!,
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
        author: authors[2],
        genre: "Dystopian",
        description: "A classic dystopian novel that delves into themes of government surveillance and totalitarianism.",
        coverImageURL: UIImage(named: "1984")!,
        tags: [Tag(id: "3", name: "Classic"), Tag(id: "4", name: "Dystopian")],
        rating: 4.8,
        price: 15.99,
        rentersNearby: 7,
        seriesInfo: SeriesInfo(seriesName: "Dystopian Classics", bookOrder: 1),
        status: .currentlyReading
    ),
    
    Book(
        id: "4",
        title: "Pride and Prejudice",
        author: authors[3],
        genre: "Classic",
        description: "A story of love and social expectations in early 19th-century England.",
        coverImageURL: UIImage(named: "pride_and_prejudice")!,
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
        author: authors[4],
        genre: "Fiction",
        description: "A young girl's observations of racial injustice in the American South.",
        coverImageURL: UIImage(named: "to_kill_a_mocking_bird")!,
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
        author: authors[5],
        genre: "Mystery",
        description: "A coming-of-age murder mystery set in the marshes of North Carolina.",
        coverImageURL: UIImage(named: "where_the_crawdads_sing")!,
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
        author: authors[6],
        genre: "Classic",
        description: "A novel about the American dream and the dark side of wealth.",
        coverImageURL: UIImage(named: "great_gatsby")!,
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
        author: authors[7],
        genre: "Fiction",
        description: "A story about teenage rebellion and alienation.",
        coverImageURL: UIImage(named: "catcher_in_the_rye")!,
        tags: [Tag(id: "13", name: "Classic"), Tag(id: "14", name: "Psychological")],
        rating: 4.2,
        price: 7.99,
        rentersNearby: 5,
        seriesInfo: nil,
        status: .didNotFinish
    ),
    
    Book(
        id: "9",
        title: "Beautiful Ruins",
        author: authors[8],
        genre: "Fiction",
        description: "A novel set in both Italy and Hollywood, spanning several decades, about love and destiny.",
        coverImageURL: UIImage(named: "beautiful_ruins")!,
        tags: [Tag(id: "15", name: "Historical"), Tag(id: "16", name: "Romance")],
        rating: 4.1,
        price: 14.99,
        rentersNearby: 6,
        seriesInfo: nil,
        status: .wantToRead
    ),
    
    Book(
        id: "10",
        title: "One Italian Summer",
        author: authors[9],
        genre: "Romance",
        description: "A woman spends a transformative summer in Italy, reconnecting with her mother and her roots.",
        coverImageURL: UIImage(named: "one_italian_summer")!,
        tags: [Tag(id: "17", name: "Romance"), Tag(id: "18", name: "Adventure")],
        rating: 4.3,
        price: 13.49,
        rentersNearby: 4,
        seriesInfo: nil,
        status: .currentlyReading
    ),
    
    Book(
        id: "11",
        title: "Under the Tuscan Sun",
        author: authors[10],
        genre: "Travel",
        description: "A memoir about a woman's adventures in Italy, finding herself in a new culture and home.",
        coverImageURL: UIImage(named: "under_the_tuscan_sun")!,
        tags: [Tag(id: "19", name: "Memoir"), Tag(id: "20", name: "Travel")],
        rating: 4.6,
        price: 16.99,
        rentersNearby: 5,
        seriesInfo: nil,
        status: .finished
    ),
    
    Book(
        id: "12",
        title: "Dark Matter",
        author: authors[11],
        genre: "Sci-Fi",
        description: "A thrilling science fiction novel about parallel universes and the choices that define us.",
        coverImageURL: UIImage(named: "dark_matter")!,
        tags: [Tag(id: "21", name: "Sci-Fi"), Tag(id: "22", name: "Thriller")],
        rating: 4.7,
        price: 14.49,
        rentersNearby: 8,
        seriesInfo: nil,
        status: .wantToRead
    ),
    
    Book(
        id: "13",
        title: "Harry Potter and the Goblet of Fire",
        author: authors[12],
        genre: "Fantasy",
        description: "The fourth book in the Harry Potter series, filled with magic, adventure, and the Triwizard Tournament.",
        coverImageURL: UIImage(named: "harry_potter_goblet_of_fire")!,
        tags: [Tag(id: "23", name: "Fantasy"), Tag(id: "24", name: "Adventure")],
        rating: 4.9,
        price: 19.99,
        rentersNearby: 10,
        seriesInfo: SeriesInfo(seriesName: "Harry Potter", bookOrder: 4),
        status: .finished
    ),
    
    Book(
        id: "14",
        title: "Percy Jackson: The Lightning Thief",
        author: authors[13],
        genre: "Fantasy",
        description: "A young boy discovers he is the son of Poseidon and embarks on an adventure in the world of Greek mythology.",
        coverImageURL: UIImage(named: "percy_jackson")!,
        tags: [Tag(id: "25", name: "Fantasy"), Tag(id: "26", name: "Adventure")],
        rating: 4.6,
        price: 12.99,
        rentersNearby: 9,
        seriesInfo: SeriesInfo(seriesName: "Percy Jackson and the Olympians", bookOrder: 1),
        status: .currentlyReading
    ),
    
    Book(
        id: "15",
        title: "A Man Called Ove",
        author: authors[14],
        genre: "Fiction",
        description: "A grumpy old man finds his life turned upside down by new neighbors who bring friendship and hope.",
        coverImageURL: UIImage(named: "a_man_called_ove")!,
        tags: [Tag(id: "27", name: "Humor"), Tag(id: "28", name: "Feel Good")],
        rating: 4.8,
        price: 13.49,
        rentersNearby: 7,
        seriesInfo: nil,
        status: .finished
    ),
    Book(
        id: "16",
        title: "Killers of the Flower Moon",
        author: authors[15],
        genre: "Historical",
        description: "A historical account of the Osage murders and the birth of the FBI.",
        coverImageURL: UIImage(named: "killers_of_the_flower_moon")!,
        tags: [Tag(id: "29", name: "Historical"), Tag(id: "30", name: "Nonfiction")],
        rating: 4.9,
        price: 18.99,
        rentersNearby: 4,
        seriesInfo: nil,
        status: .wantToRead
    ),
    Book(
        id: "17",
        title: "The Alchemist",
        author: authors[17],
        genre: "Fiction",
        description: "A philosophical tale about following your dreams.",
        coverImageURL: UIImage(named: "the_alchemist")!,
        tags: [Tag(id: "31", name: "Inspirational"), Tag(id: "32", name: "Adventure")],
        rating: 4.5,
        price: 9.99,
        rentersNearby: 6,
        seriesInfo: nil,
        status: .finished
    ),
    Book(
        id: "18",
        title: "Brida",
        author: authors[17],
        genre: "Fiction",
        description: "A mystical journey of self-discovery and spiritual awakening.",
        coverImageURL: UIImage(named: "brida")!,
        tags: [Tag(id: "33", name: "Spirituality"), Tag(id: "34", name: "Fiction")],
        rating: 4.3,
        price: 11.99,
        rentersNearby: 4,
        seriesInfo: nil,
        status: .wantToRead
    ),
    Book(
        id: "21",
        title: "The Colour of Magic",
        author: authors[16],
        genre: "Fantasy",
        description: "The first novel in the Discworld series, introducing Rincewind, the inept wizard, and his adventures.",
        coverImageURL: UIImage(named: "color_of_magic")!,
        tags: [Tag(id: "41", name: "Fantasy"), Tag(id: "42", name: "Adventure")],
        rating: 4.2,
        price: 12.99,
        rentersNearby: 5,
        seriesInfo: SeriesInfo(seriesName: "Discworld", bookOrder: 1),
        status: .finished
    ),
    Book(
        id: "22",
        title: "Mort",
        author: authors[16],
        genre: "Fantasy",
        description: "The tale of Mort, a young apprentice to Death, and his misadventures.",
        coverImageURL: UIImage(named: "mort")!,
        tags: [Tag(id: "43", name: "Fantasy"), Tag(id: "44", name: "Humor")],
        rating: 4.5,
        price: 13.99,
        rentersNearby: 6,
        seriesInfo: SeriesInfo(seriesName: "Discworld: Death Series", bookOrder: 4),
        status: .finished
    ),
    Book(
        id: "23",
        title: "Guards! Guards!",
        author: authors[16],
        genre: "Fantasy",
        description: "Follow the exploits of the Night Watch as they try to save the city of Ankh-Morpork.",
        coverImageURL: UIImage(named: "guards_guards")!,
        tags: [Tag(id: "45", name: "Fantasy"), Tag(id: "46", name: "Satire")],
        rating: 4.7,
        price: 14.99,
        rentersNearby: 4,
        seriesInfo: SeriesInfo(seriesName: "Discworld: City Watch", bookOrder: 8),
        status: .finished
    ),
    Book(
        id: "24",
        title: "Equal Rites",
        author: authors[16],
        genre: "Fantasy",
        description: "A humorous take on gender roles in magic, introducing Granny Weatherwax.",
        coverImageURL: UIImage(named: "equal_rites")!,
        tags: [Tag(id: "47", name: "Fantasy"), Tag(id: "48", name: "Humor")],
        rating: 4.3,
        price: 10.99,
        rentersNearby: 5,
        seriesInfo: SeriesInfo(seriesName: "Discworld: Witches", bookOrder: 3),
        status: .finished
    ),
    Book(
        id: "25",
        title: "Hogfather",
        author: authors[16],
        genre: "Fantasy",
        description: "A festive Discworld tale where Death takes on the role of Santa Claus.",
        coverImageURL: UIImage(named: "hogfather")!,
        tags: [Tag(id: "49", name: "Fantasy"), Tag(id: "50", name: "Holiday")],
        rating: 4.6,
        price: 15.99,
        rentersNearby: 6,
        seriesInfo: SeriesInfo(seriesName: "Discworld: Death Series", bookOrder: 20),
        status: .finished
    ),
    Book(
        id: "26",
        title: "Reaper Man",
        author: authors[16],
        genre: "Fantasy",
        description: "Death takes a break, leading to chaos across the Discworld.",
        coverImageURL: UIImage(named: "reaper_man")!,
        tags: [Tag(id: "51", name: "Fantasy"), Tag(id: "52", name: "Dark Humor")],
        rating: 4.8,
        price: 12.49,
        rentersNearby: 7,
        seriesInfo: SeriesInfo(seriesName: "Discworld: Death Series", bookOrder: 11),
        status: .finished
    ),
    Book(
        id: "27",
        title: "Small Gods",
        author: authors[16],
        genre: "Fantasy",
        description: "A standalone novel exploring religion, belief, and philosophy in the Discworld.",
        coverImageURL: UIImage(named: "small_gods")!,
        tags: [Tag(id: "53", name: "Fantasy"), Tag(id: "54", name: "Philosophy")],
        rating: 4.9,
        price: 14.99,
        rentersNearby: 8,
        seriesInfo: SeriesInfo(seriesName: "Discworld: Standalone", bookOrder: 12),
        status: .finished
    ),
    Book(
        id: "28",
        title: "Thud!",
        author: authors[16],
        genre: "Fantasy",
        description: "The Night Watch must solve a murder and prevent a civil war.",
        coverImageURL: UIImage(named: "thud")!,
        tags: [Tag(id: "55", name: "Fantasy"), Tag(id: "56", name: "Mystery")],
        rating: 4.4,
        price: 11.99,
        rentersNearby: 4,
        seriesInfo: SeriesInfo(seriesName: "Discworld: City Watch", bookOrder: 34),
        status: .finished
    ),
    Book(
        id: "29",
        title: "Going Postal",
        author: authors[16],
        genre: "Fantasy",
        description: "A conman turned postmaster revitalizes the postal service in Ankh-Morpork.",
        coverImageURL: UIImage(named: "going_postal")!,
        tags: [Tag(id: "57", name: "Fantasy"), Tag(id: "58", name: "Satire")],
        rating: 4.8,
        price: 13.99,
        rentersNearby: 5,
        seriesInfo: SeriesInfo(seriesName: "Discworld: Industrial Revolution", bookOrder: 33),
        status: .finished
    ),
    Book(
        id: "30",
        title: "The Wee Free Men",
        author: authors[16],
        genre: "Fantasy",
        description: "A young witch teams up with mischievous pictsies to save her brother.",
        coverImageURL: UIImage(named: "wee_free_men")!,
        tags: [Tag(id: "59", name: "Fantasy"), Tag(id: "60", name: "Adventure")],
        rating: 4.7,
        price: 12.49,
        rentersNearby: 6,
        seriesInfo: SeriesInfo(seriesName: "Discworld: Tiffany Aching", bookOrder: 30),
        status: .finished
    )

]

