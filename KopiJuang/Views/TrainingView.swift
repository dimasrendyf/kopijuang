//
//  TrainingView.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 20/04/26.
//

import SwiftUI

struct TrainingView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: TrainingViewModel
    var onCloseEntireSheet: () -> Void

    init(
        category: FlavorCategory,
        stage: DiscoveryStage = .taste,
        onCloseEntireSheet: @escaping () -> Void
    ) {
        _viewModel = State(
            wrappedValue: TrainingViewModel(category: category, stage: stage)
        )
        self.onCloseEntireSheet = onCloseEntireSheet
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                VStack(spacing: 16) {
                    Image(systemName: "hand.raised.square.on.square.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(Color.brown)
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)

                    VStack(spacing: 4) {
                        Text("Kenali \(viewModel.category.rawValue)")
                            .font(.title2.bold())
                            .multilineTextAlignment(.center)

                        Text(viewModel.stageSubtitle)
                            .font(.subheadline)
                            .foregroundStyle(Color.primary.opacity(0.72))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                }
                .padding(.top)

                VStack(alignment: .leading, spacing: 16) {
                    Label("Latihan singkat", systemImage: "sparkles")
                        .font(.headline)
                        .foregroundStyle(.brown)

                    Text(viewModel.trainingPrompt)
                        .font(.subheadline)
                        .lineSpacing(4)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(16)
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 16) {
                    Text("Langkah:")
                        .font(.headline)

                    TrainingStepRow(number: 1, text: viewModel.stageSteps[0])
                    if viewModel.stageSteps.count > 1 {
                        TrainingStepRow(number: 2, text: viewModel.stageSteps[1])
                    }
                }
                .padding(.horizontal)

                Text(viewModel.referenceNote)
                    .font(.caption)
                    .foregroundStyle(Color.primary.opacity(0.72))
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer(minLength: 0)

                VStack(spacing: 12) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Eksplor kategori lain")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.brown)
                            .foregroundStyle(.white)
                            .cornerRadius(12)
                    }

                    Button {
                        onCloseEntireSheet()
                    } label: {
                        Text("Aku sudah paham, kembali pilih")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.clear)
                            .foregroundStyle(.brown)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.brown, lineWidth: 1)
                            )
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        .navigationTitle("Latihan")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Komponen Langkah-langkah
struct TrainingStepRow: View {
    let number: Int
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text("\(number)")
                .font(.subheadline.bold())
                .foregroundStyle(.brown)
                .frame(width: 32, height: 32)
                .background(Color.brown.opacity(0.1))
                .clipShape(Circle())

            Text(text)
                .font(.subheadline)
                .padding(.top, 4)
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        TrainingView(category: .fruity, stage: .taste, onCloseEntireSheet: {})
    }
}
