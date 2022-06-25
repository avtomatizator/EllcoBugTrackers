//
//  BugResponse.swift
//  EllcoBugTrackers
//
//  Created by admin on 24.06.2022.
//

import Foundation

struct BugResponse: Codable {
    
    let bugTrackers: [BugTracker]
    let bugTrackersCount: Int
    let totalPages: Int
    let currentPage: Int
    
    
    enum CodingKeys: String, CodingKey {
        case bugTrackers = "bug_trackers"
        case bugTrackersCount = "bug_trackers_count"
        case totalPages = "totalPages"
        case currentPage = "currentPage"
        
    }
}

