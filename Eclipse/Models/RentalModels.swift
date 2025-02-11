//
//  RentalModels.swift
//  Eclipse
//
//  Created by admin48 on 11/02/25.
//

import Foundation
import FirebaseFirestore

struct RentalRecord: Codable {
    let id: String
    let bookId: String
    let userId: String
    let rentedDate: Date
    let dueDate: Date
    let returnedDate: Date?
    let isCollectorsEdition: Bool
    let status: RentalStatus
    
    enum RentalStatus: String, Codable {
        case active
        case overdue
        case returned
        case cancelled
    }
}

struct UserProfile: Codable {
    let id: String
    let name: String
    let rating: Double
    let totalRatings: Int
    let distance: Double?
    let activeRentals: [String]
    let pastRentals: [String]
    let collectorsEditionBooks: [String]
}
