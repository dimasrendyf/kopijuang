//
//  UserProgressStore.swift
//  KopiJuang
//

import Foundation
import SwiftData

enum UserProgressStore {
    static func primary(from progresses: [UserProgress], in modelContext: ModelContext) -> UserProgress {
        guard let first = progresses.first else {
            let fresh = UserProgress()
            modelContext.insert(fresh)
            return fresh
        }
        return first
    }
}
