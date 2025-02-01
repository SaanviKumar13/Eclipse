//
//  DataManager.swift
//  Eclipse
//
//  Created by user@87 on 25/01/25.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class DataManager {
    static let shared = DataManager()

    private let db = Firestore.firestore()
    private var userID: String? {
        return Auth.auth().currentUser?.uid
    }

    private init() {}

    // Fetch Status Lists
    func fetchStatusLists(completion: @escaping (Result<[List], Error>) -> Void) {
        guard let userID = userID else {
            completion(.failure(NSError(domain: "Auth", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"])))
            return
        }

        let statusListsRef = db.collection("users").document(userID).collection("statusLists")
        statusListsRef.getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            var statusLists: [List] = []
            snapshot?.documents.forEach { document in
                let data = document.data()
                let title = data["title"] as? String ?? "Untitled"
                let bookIDs = data["bookIDs"] as? [String] ?? []
                let isPrivate = data["isPrivate"] as? Bool ?? false

                statusLists.append(List(title: title, bookIDs: bookIDs, isPrivate: isPrivate))
            }
            completion(.success(statusLists))
        }
    }

    // Fetch Custom Lists
    func fetchCustomLists(completion: @escaping (Result<[List], Error>) -> Void) {
        guard let userID = userID else {
            completion(.failure(NSError(domain: "Auth", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"])))
            return
        }

        let customListsRef = db.collection("users").document(userID).collection("customLists")
        customListsRef.getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            var customLists: [List] = []
            snapshot?.documents.forEach { document in
                let data = document.data()
                let title = data["title"] as? String ?? "Untitled"
                let bookIDs = data["bookIDs"] as? [String] ?? []
                let isPrivate = data["isPrivate"] as? Bool ?? false

                customLists.append(List(title: title, bookIDs: bookIDs, isPrivate: isPrivate))
            }
            completion(.success(customLists))
        }
    }

    // Add New Custom List
    func addCustomList(list: List, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let userID = userID else {
            completion(.failure(NSError(domain: "Auth", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"])))
            return
        }

        let customListsRef = db.collection("users").document(userID).collection("customLists")
        let newList = [
            "title": list.title,
            "bookIDs": list.bookIDs,
            "isPrivate": list.isPrivate
        ] as [String: Any]

        customListsRef.addDocument(data: newList) { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }
}
