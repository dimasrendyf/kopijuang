//
//  AtlasView.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 19/04/26.
//

import SwiftUI

struct AtlasView: View {
    @State private var searchText = ""
    
    // Mock Data - Nanti ini bisa diambil dari SwiftData
    @State var flavors: [FlavorNote] = [
        FlavorNote(name: "Citrus", category: "Fruity", description: "Asam segar seperti jeruk.", icon: "tree.fill", isUnlocked: true),
        FlavorNote(name: "Berry", category: "Fruity", description: "Manis asam khas stroberi.", icon: "laurel.trailing", isUnlocked: false),
        FlavorNote(name: "Jasmine", category: "Floral", description: "Aroma bunga yang halus.", icon: "tree.fill", isUnlocked: false),
        FlavorNote(name: "Hazelnut", category: "Nutty", description: "Rasa kacang sangrai.", icon: "circle.circle.fill", isUnlocked: true)
    ]
    
    // Logic Search
    var filteredFlavors: [FlavorNote] {
        if searchText.isEmpty { return flavors }
        return flavors.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    let columns = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(filteredFlavors) { flavor in
                        NavigationLink(destination: FlavorDetailView(flavor: flavor)) {
                            FlavorCard(flavor: flavor)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Flavor Atlas")
            .searchable(text: $searchText, prompt: "Cari rasa...")
        }
    }
}

#Preview {
    AtlasView()
}

struct FlavorCard: View {
    let flavor: FlavorNote
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: flavor.isUnlocked ? flavor.icon : "lock.fill")
                .font(.system(size: 40))
                .foregroundColor(flavor.isUnlocked ? .brown : .gray)
            
            Text(flavor.isUnlocked ? flavor.name : "???")
                .font(.headline)
                .foregroundColor(flavor.isUnlocked ? .brown : .gray)
        }
        .frame(height: 140)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.secondarySystemBackground)))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(flavor.isUnlocked ? Color.brown.opacity(0.3) : Color.clear, lineWidth: 2)
        )
    }
}
