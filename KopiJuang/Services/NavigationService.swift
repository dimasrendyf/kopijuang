//
//  NavigationService.swift
//  KopiJuang
//

import Foundation

/// Bump counter so `MainTabView` rebuilds root (back to dashboard).
enum NavigationService {
    static func popToRootView() {
        let defaults = UserDefaults.standard
        let counter = defaults.integer(forKey: "dashboardResetCounter")
        defaults.set(counter + 1, forKey: "dashboardResetCounter")
    }
}
