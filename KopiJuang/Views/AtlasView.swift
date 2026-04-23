//
//  AtlasView.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 19/04/26.
//

import SwiftUI
import SwiftData

struct AtlasView: View {
    @State private var viewModel = AtlasViewModel()
    @Query private var userProgresses: [UserProgress]
    
    let columns = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        @Bindable var viewModel = viewModel
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.filteredFlavors(from: userProgresses)) { flavor in
                        NavigationLink(destination: FlavorDetailView(flavor: flavor)) {
                            FlavorCard(flavor: flavor)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Flavor Atlas")
            .searchable(text: $viewModel.searchText, prompt: "Cari rasa...")
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
