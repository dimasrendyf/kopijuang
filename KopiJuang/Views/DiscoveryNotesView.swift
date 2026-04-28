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
                    Text("Panduan evaluasi rasa")
                        .font(.title2.bold())
                    Text(footerCopy)
                        .font(.subheadline)
                        .foregroundStyle(Color.primary.opacity(0.72))
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
                            Text(stage.learningLine(for: category))
                                .font(.caption)
                                .foregroundStyle(Color.primary.opacity(0.72))
                        }
                    }
                }
            } header: {
                Text("9 Kelompok Flavor · SCA Wheel")
            }
//            footer: {
//                Text("Daftar ini selaras peta kategori di latihan; bukan salinan peta resmi pihak ketiga.")
//                    .font(.caption)
//                    .foregroundStyle(.secondary)
//            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Panduan Rasa")
        .navigationBarTitleDisplayMode(.large)
    }

    private var footerCopy: String {
        "Pilih kelompok rasa untuk fase \(stage.title). Baca panduan, bandingkan langsung dengan cangkir di depanmu, lalu kembali ke form evaluasi."
    }
}

#Preview {
    NavigationStack {
        DiscoveryNotesView(stage: .taste) {}
    }
}
