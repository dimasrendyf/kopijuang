//
//  AtlasView.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 19/04/26.
//

import SwiftUI
import SwiftData

struct AtlasView: View {
    @State private var searchText = ""
    @Query private var userProgresses: [UserProgress]
    
    // Convert FlavorWheelData to FlavorNote
    private var flavors: [FlavorNote] {
        let unlockedPrimary = Set(userProgresses.flatMap(\.unlockedPrimaryNotes))
        let unlockedSecondary = Set(userProgresses.flatMap(\.unlockedSecondaryNotes))
        let unlockedSpecific = Set(userProgresses.flatMap(\.unlockedSpecificNotes))
        let experienced = userProgresses.flatMap(\.allExperiencedNotes)
        var list: [FlavorNote] = []
        
        func traverse(_ node: FlavorWheelNode) {
            let isUnlocked: Bool
            if node.layer == 1 {
                isUnlocked = unlockedPrimary.contains(node.name)
            } else if node.layer == 2 {
                isUnlocked = unlockedSecondary.contains(node.name)
            } else {
                isUnlocked = unlockedSpecific.contains(node.name)
            }

            let experienceCount = experienced.filter { $0 == node.name }.count
            
            list.append(FlavorNote(
                name: node.name,
                category: node.layer == 1 ? node.name : (node.parent ?? ""),
                description: node.description,
                icon: node.layer == 1 ? "star.fill" : "circle.fill",
                isUnlocked: isUnlocked,
                experienceCount: experienceCount,
                familiarityLevel: familiarityLabel(for: experienceCount)
            ))
            node.children.forEach { traverse($0) }
        }
        
        FlavorWheelData.wheel.forEach { traverse($0) }
        return list
    }

    private func familiarityLabel(for count: Int) -> String {
        switch count {
        case 0:
            return "Belum dijelajahi"
        case 1...2:
            return "Pemula"
        case 3...5:
            return "Kenal"
        case 6...9:
            return "Akrab"
        default:
            return "Peka"
        }
    }
    
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

            if flavor.isUnlocked {
                Text("\(flavor.familiarityLevel) • \(flavor.experienceCount)x")
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
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
