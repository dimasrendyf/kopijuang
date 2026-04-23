//
//  TrainingView.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 20/04/26.
//

import SwiftUI

struct TrainingView: View {
    @Environment(\.dismiss) var dismiss
    @State private var viewModel: TrainingViewModel

    init(flavor: String, stage: DiscoveryStage = .taste) {
        _viewModel = State(wrappedValue: TrainingViewModel(flavor: flavor, stage: stage))
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
                        Text("Ayo kenali \(viewModel.flavor)!")
                            .font(.title2.bold())
                            .multilineTextAlignment(.center)

                        Text(viewModel.stageSubtitle)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.top)

                VStack(alignment: .leading, spacing: 16) {
                    Label("Siapkan \(viewModel.flavor)", systemImage: "sparkles")
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
                    Text("Langkah Latihan:")
                        .font(.headline)

                    TrainingStepRow(number: 1, text: viewModel.stageSteps[0])
                    TrainingStepRow(number: 2, text: viewModel.stageSteps[1])
                    TrainingStepRow(number: 3, text: viewModel.stageSteps[2])
                }
                .padding(.horizontal)

                Spacer()

                VStack(spacing: 12) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Coba tebak lagi")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.brown)
                            .foregroundStyle(.white)
                            .cornerRadius(12)
                    }

                    Button {
                        NavigationService.popToRootView()
                    } label: {
                        Text("Selesai & Kembali ke Dashboard")
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
    TrainingView(flavor: "Citrus", stage: .taste)
}
