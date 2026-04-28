//
//  MainTabView.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 19/04/26.
//

import SwiftUI

struct MainTabView: View {
    @AppStorage("dashboardResetCounter") private var dashboardResetCounter: Int = 0
    @State private var viewModel = MainTabViewModel()

    var body: some View {
        NavigationStack {
            TabView(selection: $viewModel.selectedTab) {
                DashboardView()
                    .tabItem {
                        Label("Dashboard", systemImage: "house.fill")
                    }
                    .tag(0)
                
                AtlasView()
                    .tabItem {
                        Label("Atlas", systemImage: "book.fill")
                    }
                    .tag(1)
            }
            .accentColor(.brown)
            .onChange(of: dashboardResetCounter) { _, _ in
                viewModel.resetToDashboardTab()
            }
        }
        .id("navigation-root-\(dashboardResetCounter)")
    }
}

#Preview {
    MainTabView()
}
