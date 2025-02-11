//
//  RentalService.swift
//  Eclipse
//
//  Created by admin48 on 11/02/25.
//

import Foundation
import FirebaseFirestore

class RentalService {
    static let shared = RentalService()
    private let db = Firestore.firestore()
    
    private let rentalsCollection = "rentals"
    private let usersCollection = "users"
    private let booksCollection = "books"
    
    // Add methods one by one as needed
    func rentBook(bookF: BookF, userId: String, isCollectorsEdition: Bool) async throws -> RentalRecord {
        let rentalId = UUID().uuidString
        let currentDate = Date()
        let dueDate = Calendar.current.date(byAdding: .day, value: 14, to: currentDate)!
        
        let rental = RentalRecord(
            id: rentalId,
            bookId: bookF.id,
            userId: userId,
            rentedDate: currentDate,
            dueDate: dueDate,
            returnedDate: nil,
            isCollectorsEdition: isCollectorsEdition,
            status: .active
        )
        
        try await db.collection(rentalsCollection).document(rentalId).setData([
            "id": rental.id,
            "bookId": rental.bookId,
            "userId": rental.userId,
            "rentedDate": rental.rentedDate,
            "dueDate": rental.dueDate,
            "isCollectorsEdition": rental.isCollectorsEdition,
            "status": rental.status.rawValue
        ])
        
        return rental
    }
    enum RentalStatus: String {
        case available = "Available"
        case rented = "Rented"
        case reserved = "Reserved"
    }

    
    func getUserRentals(userId: String) async throws -> [String] {
        let snapshot = try await db.collection(rentalsCollection)
            .whereField("userId", isEqualTo: userId)
//            .whereField("status", isEqualTo: RentalStatus.active.rawValue)
            .getDocuments()
            
        return snapshot.documents.map { $0.data()["bookId"] as? String ?? "" }
    }
    
    func getCollectorsBooks(userId: String) async throws -> [String] {
        let document = try await db.collection(usersCollection)
            .document(userId)
            .getDocument()
            
        return document.data()?["collectorsEditionBooks"] as? [String] ?? []
    }
}
