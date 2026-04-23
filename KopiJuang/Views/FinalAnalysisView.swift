//
//  FinalAnalysisView.swift
//  KopiJuang
//

import SwiftUI
import SwiftData

struct FinalAnalysisView: View {
    @Query private var userProgresses: [UserProgress]
    @State private var viewModel: FinalAnalysisViewModel

    init(
        evaluation: SensoryEvaluation,
        primaryCategory: FlavorCategory,
        selectedNode: FlavorWheelNode?
    ) {
        _viewModel = State(
            wrappedValue: FinalAnalysisViewModel(
                evaluation: evaluation,
                primaryCategory: primaryCategory,
                selectedNode: selectedNode
            )
        )
    }

    var body: some View {
        let expCount = viewModel.selectedNoteExperienceCount(from: userProgresses)
        let fam = viewModel.familiarityLevel(experienceCount: expCount)

        ScrollView {
            VStack(spacing: 18) {
                VStack(spacing: 8) {
                    Text("Hasil Analisis Final")
                        .font(.title2.bold())
                    Text("Ringkasan akhir setelah kamu memilih profil rasa sampai layer terluar.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 8)

                FinalCard(title: "Highlight profil") {
                    Text(viewModel.spotlightMessage)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                FinalCard(title: "Data yang terekam") {
                    Text(viewModel.flowDataSummary)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.leading)
                }

                FinalCard(title: "Profil Akhir") {
                    VStack(alignment: .leading, spacing: 8) {
                        profileChip(text: viewModel.primaryCategory.rawValue)
                        if let secondaryNote = viewModel.secondaryNote {
                            profileChip(text: secondaryNote)
                        }
                        if let specificNote = viewModel.specificNote {
                            profileChip(text: specificNote)
                        }
                    }
                }

                FinalCard(title: "Saran Next Seduhan") {
                    Text(viewModel.brewGuidance)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                FinalCard(title: "Progress Familiarity") {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Level saat ini: \(fam)")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.brown)
                        if let specificNote = viewModel.specificNote {
                            Text("Note \(specificNote) sudah kamu rasakan \(expCount)x.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        } else if let secondaryNote = viewModel.secondaryNote {
                            Text("Note \(secondaryNote) sudah kamu rasakan \(expCount)x.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        } else {
                            Text("Terus ulangi sesi di kategori ini agar familiarity naik bertahap.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                Button {
                    NavigationService.popToRootView()
                } label: {
                    Text("Selesai & Kembali ke Dashboard")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.brown)
                        .foregroundStyle(.white)
                        .cornerRadius(14)
                }
                .padding(.top, 6)
            }
            .padding()
        }
        .background(Color(.secondarySystemBackground))
        .navigationBarBackButtonHidden(true)
    }

    private func profileChip(text: String) -> some View {
        Text(text)
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.brown)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(Color.brown.opacity(0.12))
            .clipShape(Capsule())
    }
}

private struct FinalCard<Content: View>: View {
    let title: String
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.brown)
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
    }
}
