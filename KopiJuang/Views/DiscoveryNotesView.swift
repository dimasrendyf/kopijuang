//
//  DiscoveryNotesView.swift
//  KopiJuang
//

import SwiftUI

struct DiscoveryNotesView: View {
    let stage: DiscoveryStage
    var onCloseEntireSheet: (() -> Void)?

    private let categories = FlavorCategory.allCases

    init(stage: DiscoveryStage, onCloseEntireSheet: (() -> Void)? = nil) {
        self.stage = stage
        self.onCloseEntireSheet = onCloseEntireSheet
    }

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Bantuan pengecapan")
                        .font(.title2.bold())
                    Text(footerCopy)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.vertical, 4)
            }
            .listRowBackground(Color.clear)

            Section {
                ForEach(categories) { category in
                    NavigationLink {
                        TrainingView(
                            category: category,
                            stage: stage,
                            onCloseEntireSheet: { onCloseEntireSheet?() }
                        )
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(category.rawValue)
                                .font(.subheadline.weight(.semibold))
                            Text("\(stage.learningLine) \(category.rawValue.lowercased())")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            } header: {
                Text("Kelompok aroma & rasa")
            } footer: {
                Text("Daftar ini selaras peta kategori di latihan; bukan salinan peta resmi pihak ketiga.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Catatan pengecapan")
        .navigationBarTitleDisplayMode(.large)
    }

    private var footerCopy: String {
        "Pilih kelompok yang mau dilatih. Ringkasan mengikuti fase \(stage.title)—bandingkan dengan cangkirmu, lalu kembali ke form."
    }
}

#Preview {
    NavigationStack {
        DiscoveryNotesView(stage: .taste) {}
    }
}
