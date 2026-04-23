//
//  DiscoveryNotesView.swift
//  KopiJuang
//

import SwiftUI

struct DiscoveryNotesView: View {
    let stage: DiscoveryStage

    private let categories = FlavorCategory.allCases

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Aku Gak Yakin, Bantuin Dong")
                        .font(.title3.bold())
                    Text("Pilih notes yang ingin kamu pelajari. Materi akan menyesuaikan tahap \(stage.title.lowercased()).")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 6)
            }
            .listRowBackground(Color.clear)

            Section("Belajar Notes") {
                ForEach(categories) { category in
                    NavigationLink(destination: TrainingView(flavor: category.rawValue, stage: stage)) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Belajar notes \(category.rawValue)")
                                .font(.subheadline.weight(.semibold))
                            Text("\(stage.learningPrefix) \(category.rawValue.lowercased())")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
        .navigationTitle("Discovery Notes")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        DiscoveryNotesView(stage: .taste)
    }
}
