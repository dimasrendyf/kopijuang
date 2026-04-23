//
//  MainTabViewModel.swift
//  KopiJuang
//

import Foundation
import Observation

@MainActor
@Observable
final class MainTabViewModel {
    var selectedTab: Int = 0

    func resetToDashboardTab() {
        selectedTab = 0
    }
}
