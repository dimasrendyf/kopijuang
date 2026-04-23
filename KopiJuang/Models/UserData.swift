//
//  UserData.swift
//  KopiJuang
//

import Foundation
import SwiftData

@Model
class UserProgress {
    var unlockedPrimaryNotes: [String]
    var unlockedSecondaryNotes: [String]
    var unlockedSpecificNotes: [String]
    var totalCorrectGuesses: Int
    
    @Relationship(deleteRule: .cascade) var completedSessions: [SessionHistory]
    @Relationship(deleteRule: .cascade) var badges: [UserBadge]
    
    init(unlockedPrimaryNotes: [String] = [], unlockedSecondaryNotes: [String] = [], unlockedSpecificNotes: [String] = [], totalCorrectGuesses: Int = 0, completedSessions: [SessionHistory] = [], badges: [UserBadge] = []) {
        self.unlockedPrimaryNotes = unlockedPrimaryNotes
        self.unlockedSecondaryNotes = unlockedSecondaryNotes
        self.unlockedSpecificNotes = unlockedSpecificNotes
        self.totalCorrectGuesses = totalCorrectGuesses
        self.completedSessions = completedSessions
        self.badges = badges
    }
}

@Model
class SessionHistory {
    var id: UUID
    var date: Date
    var beanName: String
    var roastLevel: String
    var processLevel: String
    var finalCategory: String
    
    init(id: UUID = UUID(), date: Date = Date(), beanName: String, roastLevel: String, processLevel: String, finalCategory: String) {
        self.id = id
        self.date = date
        self.beanName = beanName
        self.roastLevel = roastLevel
        self.processLevel = processLevel
        self.finalCategory = finalCategory
    }
}

@Model
class UserBadge {
    var id: UUID
    var name: String
    var category: String
    var layer: Int
    var dateEarned: Date
    
    init(id: UUID = UUID(), name: String, category: String, layer: Int, dateEarned: Date = Date()) {
        self.id = id
        self.name = name
        self.category = category
        self.layer = layer
        self.dateEarned = dateEarned
    }
}
