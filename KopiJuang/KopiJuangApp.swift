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

    private let modelContainer: ModelContainer

    init() {
        do {
            modelContainer = try ModelContainer(for: UserProgress.self, SessionHistory.self, UserBadge.self)
        } catch {
            Self.removeDefaultStoreIfPresent()
            do {
                modelContainer = try ModelContainer(for: UserProgress.self, SessionHistory.self, UserBadge.self)
            } catch {
                fatalError("ModelContainer could not be created: \(error)")
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            if hasCompletedFirstSession {
                MainTabView()
            } else {
                ContentView()  // belum pernah onboarding
            }
        }
        .modelContainer(modelContainer)
    }

    private static func removeDefaultStoreIfPresent() {
        let fm = FileManager.default
        guard let appSupport = fm.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else { return }
        // SwiftData default URL name (default.store) + SQLite sidecars
        let base = appSupport.appendingPathComponent("default.store", isDirectory: false)
        let sidecars: [URL] = [
            base,
            appSupport.appendingPathComponent("default.store-wal", isDirectory: false),
            appSupport.appendingPathComponent("default.store-shm", isDirectory: false),
        ]
        for url in sidecars {
            if fm.fileExists(atPath: url.path) {
                try? fm.removeItem(at: url)
            }
        }
    }
}
