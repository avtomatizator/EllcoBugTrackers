//
//  BugTracker.swift
//  EllcoBugTrackers
//
//  Created by admin on 24.06.2022.
//

import Foundation

struct BugTracker: Codable {
    let id: Int
    let name: String
    let description: String
    let sender: Sender
    let product: Product
    let status: Status
    let createdAt: CreatedTime
    
    
}
