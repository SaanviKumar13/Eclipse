import Foundation

class BookAPI {
    
    static let shared = BookAPI()
    
    private let apiKey = ""
    private var cachedBooks: [String: [BookF]] = [:]
    
    private init() {}

    private func createURLSession() -> URLSession {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        return URLSession(configuration: config)
    }
    
    func fetchBooks(query: String, completion: @escaping (Result<[BookF], Error>) -> Void) {
        if let cachedData = cachedBooks[query] {
            completion(.success(cachedData))
            return
        }
        
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=subject:\(encodedQuery)&key=\(apiKey)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        let session = createURLSession()
        
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 404, userInfo: nil)))
                return
            }
            
            do {
                if let jsonObj = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                   let itemsArray = jsonObj["items"] as? [[String: Any]] {
                    
                    var books: [BookF] = []
                    
                    for item in itemsArray {
                        if let volumeInfo = item["volumeInfo"] as? [String: Any] {
                            let id = item["id"] as? String ?? "Unknown ID"
                            let title = (volumeInfo["title"] as? String)?.trimmingCharacters(in: .whitespacesAndNewlines)
                            let subtitle = (volumeInfo["subtitle"] as? String)?.trimmingCharacters(in: .whitespacesAndNewlines)
                            let authors = volumeInfo["authors"] as? [String]
                            let description = (volumeInfo["description"] as? String)?.trimmingCharacters(in: .whitespacesAndNewlines)
                            let averageRating = volumeInfo["averageRating"] as? Double
                            let ratingsCount = volumeInfo["ratingsCount"] as? Int
                            let pageCount = volumeInfo["pageCount"] as? Int
                            let previewLink = volumeInfo["previewLink"] as? String
                            
                            var imageLinks: ImageLinks?
                            if let imageLinksDict = volumeInfo["imageLinks"] as? [String: AnyObject],
                               let smallThumbnail = imageLinksDict["smallThumbnail"] as? String,
                               let thumbnail = imageLinksDict["thumbnail"] as? String {
                                imageLinks = ImageLinks(smallThumbnail: smallThumbnail, thumbnail: thumbnail)
                            }
                            
                            let book = BookF(
                                id: id,
                                title: title ?? "Unknown Title",
                                subtitle: subtitle,
                                authors: authors,
                                description: description,
                                averageRating: averageRating,
                                ratingsCount: ratingsCount,
                                imageLinks: imageLinks,
                                previewLink: previewLink,
                                pageCount: pageCount
                            )
                            
                            books.append(book)
                        }
                    }
                    
                    self.cachedBooks[query] = books
                    completion(.success(books))
                } else {
                    completion(.failure(NSError(domain: "Invalid JSON structure", code: 500, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

