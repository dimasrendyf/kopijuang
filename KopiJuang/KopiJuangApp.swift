//
//  KopiJuangApp.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 10/04/26.
//

import SwiftUI

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
    }
}
