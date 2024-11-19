//
//  Message.swift
//  Eclipse
//
//  Created by admin48 on 17/11/24.
//

import Foundation

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isFromUser: Bool
}
