//
//  BookIDHelper.swift
//  Eclipse
//
//  Created by user@87 on 19/11/24.
//

import Foundation
import UIKit

func getBookByID(_ id: String) -> Book? {
    return mockBooks.first { $0.id == id }
}


func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
    URLSession.shared.dataTask(with: url) { data, _, error in
        if let data = data, error == nil {
            completion(UIImage(data: data))
        } else {
            completion(nil)
        }
    }.resume()
}


func fetchBookDetails(bookID: String, completion: @escaping (BookF?) -> Void) {
    let urlString = "https://www.googleapis.com/books/v1/volumes/\(bookID)"
    
    guard let url = URL(string: urlString) else {
        completion(nil)
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else {
            print("Error fetching book data: \(error?.localizedDescription ?? "Unknown error")")
            completion(nil)
            return
        }
        
        do {
            let decodedResponse = try JSONDecoder().decode([String: BookF].self, from: data)
            if let book = decodedResponse["volumeInfo"] {
                completion(book)
            } else {
                completion(nil)
            }
        } catch {
            print("Decoding error: \(error.localizedDescription)")
            completion(nil)
        }
    }.resume()
}
