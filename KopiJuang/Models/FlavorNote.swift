//
//  Untitled.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 19/04/26.
//

import SwiftUI
// untuk data di halaman atlas
struct FlavorNote: Identifiable {
    let id = UUID()
    let name: String
    let category: String // Fruity, Floral, Nutty, etc
    let description: String
    let icon: String // SF Symbol name
    var isUnlocked: Bool
}
