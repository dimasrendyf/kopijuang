//
//  MainTabView.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 19/04/26.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "house.fill")
                }
            
            AtlasView()
                .tabItem {
                    Label("Atlas", systemImage: "book.fill")
                }
        }
        .accentColor(.brown)
    }
}

#Preview {
    MainTabView()
}
