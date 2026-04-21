//
//  CoffeeFeel.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 13/04/26.
//

import SwiftUI

struct CoffeeFeelView: View {
    // "Tanda tangan" untuk ngecek apakah user udah pernah lewat onboarding
    @AppStorage("hasCompletedFirstSession") var hasCompletedFirstSession: Bool = false
    
    var body: some View {
        if hasCompletedFirstSession {
            // Pengguna lama -> Langsung ke Setup Beans (Input Info)
            MainTabView()
        } else {
            // Pengguna baru -> Wajib baca Master Prep
            MasterPrepGuideView(isFirstRun: true)
        }
    }
}

#Preview {
    CoffeeFeelView()
}
