//
//  GoogleBooksAPI.swift
//  Eclipse
//
//  Created by admin48 on 11/02/25.
//

import Foundation

// MARK: - Google Books API Models
struct GoogleBooksResponse: Codable {
    let items: [GoogleBook]?
}

struct GoogleBook: Codable {
    let id: String
    let volumeInfo: GoogleVolumeInfo
}

struct GoogleVolumeInfo: Codable {  // Renamed to avoid conflicts
    let title: String
    let subtitle: String?
    let authors: [String]?
    let description: String?
    let averageRating: Double?
    let ratingsCount: Int?
    let imageLinks: GoogleImageLinks?
    let previewLink: String?
    let pageCount: Int?
}

struct GoogleImageLinks: Codable { // Renamed to avoid conflicts
    let thumbnail: String?
}

// MARK: - API Service
class GoogleBooksAPI {
    static let shared = GoogleBooksAPI()
    
    private init() {}
    
    func fetchBook(bookID: String) async -> GoogleBook? {
        let urlString = "https://www.googleapis.com/books/v1/volumes/\(bookID)"
        
        guard let url = URL(string: urlString) else {
            print("❌ Invalid URL")
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let bookResponse = try JSONDecoder().decode(GoogleBook.self, from: data)
            return bookResponse
        } catch {
            print("❌ Error fetching book: \(error)")
            return nil
        }
    }
}
