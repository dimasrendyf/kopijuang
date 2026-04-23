//
//  KopiJuangApp.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 10/04/26.
//

import SwiftUI
import SwiftData

@main
struct KopiJuangApp: App {
    @AppStorage("hasCompletedFirstSession") var hasCompletedFirstSession: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if hasCompletedFirstSession {
                MainTabView()
            } else {
                ContentView()  // belum pernah onboarding
            }
        }
        .modelContainer(for: [UserProgress.self, SessionHistory.self, UserBadge.self])
    }
}
