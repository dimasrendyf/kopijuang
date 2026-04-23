//
//  ResultView.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 20/04/26.
//

import SwiftUI
import SwiftData

// MARK: - Main View
struct ResultView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var userProgresses: [UserProgress]

    @State private var viewModel: ResultViewModel

    init(evaluation: SensoryEvaluation) {
        _viewModel = State(wrappedValue: ResultViewModel(evaluation: evaluation))
    }

    var body: some View {
        @Bindable var viewModel = viewModel
        ScrollView {
            VStack(spacing: 24) {
                // 0. Session Meta
                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.evaluation.beanName)
                        .font(.title2.bold())
                    HStack(spacing: 8) {
                        Text(viewModel.evaluation.beanOrigin)
                        Text("•")
                        Text("Roast \(viewModel.evaluation.roastLevel)")
                        Text("•")
                        Text(viewModel.evaluation.processLevel)
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 10)
                
                // 0.5 Fragrance vs Aroma
                FragranceAromaSummaryCard(
                    fragranceCategory: viewModel.evaluation.fragranceCategory,
                    fragranceIntensity: viewModel.evaluation.fragranceIntensity,
                    aromaCategory: viewModel.evaluation.aromaCategory,
                    aromaIntensity: viewModel.evaluation.aromaIntensity,
                    aromaContrast: viewModel.evaluation.aromaContrast
                )
                .padding(.horizontal)
                
                // 1. Report Area (Card-based)
                VStack(alignment: .leading, spacing: 16) {
                    Text("Analisis Sensorik")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    
                    VStack(spacing: 12) {
                        SensoryBar(label: "Asam", value: viewModel.evaluation.acidity, max: 10)
                        SensoryBar(label: "Manis", value: viewModel.evaluation.sweetness, max: 10)
                        SensoryBar(label: "Pahit", value: viewModel.evaluation.bitterness, max: 10)
                        SensoryBar(label: "Body", value: viewModel.evaluation.bodyScore, max: 10)
                    }
                }
                .padding(24)
                .background(Color(.systemBackground))
                .cornerRadius(24)
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Saran Untuk Seduhan Besok")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    
                    Text(viewModel.brewTipInsight)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.primary)
                    
                    Text(viewModel.brewTipAction)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                .background(Color(.systemBackground))
                .cornerRadius(18)
                .shadow(color: .black.opacity(0.04), radius: 8, x: 0, y: 4)
                .padding(.horizontal)

                // 2. Question Section
                VStack(spacing: 16) {
                    Text("Menurut kamu, kategori apa yang paling menggambarkan profil kopi ini secara keseluruhan?")
                        .font(.title3.bold())
                        .multilineTextAlignment(.center)
                    Text("Tidak ada jawaban benar atau salah. Pilih yang paling mendekati pengalaman lidahmu, lalu kita lanjut eksplorasi layer berikutnya.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                    
                    LazyVGrid(columns: [GridItem(.flexible())], spacing: 12) {
                        ForEach(FlavorCategory.allCases, id: \.self) { category in
                            CategoryButton(category: category) {
                                viewModel.checkAnswer(category, modelContext: modelContext, userProgresses: userProgresses)
                            }
                            .overlay(
                                Image(systemName: viewModel.selectedCategory == category ? "checkmark.circle.fill" : "circle")
                                    .font(.title3)
                                    .foregroundStyle(viewModel.selectedCategory == category ? .brown : .secondary)
                                    .padding(12),
                                alignment: .topTrailing
                            )
                        }
                    }

                    Button {
                        viewModel.showDiscovery = true
                    } label: {
                        Text("Butuh bantuan: catatan pengecapan")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.secondary)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(.systemGray4), style: StrokeStyle(lineWidth: 1, dash: [4, 4]))
                            )
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color(.secondarySystemBackground))
        .navigationTitle("Hasil Analisis")
        .sheet(isPresented: $viewModel.showingFeedback) {
            FeedbackView(
                isCorrect: viewModel.isCorrect,
                message: viewModel.feedbackMessage,
                category: viewModel.selectedCategory ?? .fruity,
                nextAction: {
                    viewModel.onFeedbackNextTapped()
                }
            )
        }
        .navigationDestination(isPresented: $viewModel.navigateToCascading) {
            if let cat = viewModel.selectedCategory {
                CascadingQuizView(
                    evaluation: viewModel.evaluation,
                    selectedPrimaryCategory: cat,
                    parentNodeId: cat.rawValue
                )
            }
        }
        .sheet(isPresented: $viewModel.showDiscovery) {
            NavigationStack {
                DiscoveryNotesView(stage: .taste) { viewModel.showDiscovery = false }
            }
        }
    }
}

// MARK: - Components
struct SensoryBar: View {
    let label: String
    let value: Double
    let max: Double
    
    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline.bold())
                .frame(width: 80, alignment: .leading)
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(.systemGray5))
                        .frame(height: 8)
                    
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.brown.gradient)
                        .frame(width: geo.size.width * (value/max), height: 8)
                }
            }
            .frame(height: 8)
        }
    }
}

struct CategoryButton: View {
    let category: FlavorCategory
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(category.categoryAccentColor.opacity(0.18))
                        .frame(width: 44, height: 44)
                    Image(systemName: category.categoryIconName)
                        .font(.title3.weight(.semibold))
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(category.rawValue)
                        .font(.headline)
                    Text(category.categoryBlurb)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
                Spacer(minLength: 0)
            }
            .foregroundStyle(category.categoryAccentColor)
            .padding(.vertical, 14)
            .padding(.horizontal, 14)
            .background(
                LinearGradient(
                    colors: [category.categoryAccentColor.opacity(0.16), category.categoryAccentColor.opacity(0.06)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(category.categoryAccentColor.opacity(0.35), lineWidth: 1)
            )
        }
    }
}

// MARK: - Feedback View
struct FeedbackView: View {
    @Environment(\.dismiss) var dismiss
    let isCorrect: Bool
    let message: String
    let category: FlavorCategory
    var nextAction: (() -> Void)? = nil

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Image(systemName: isCorrect ? "party.popper.fill" : "lightbulb.fill")
                    .font(.system(size: 72))
                    .foregroundStyle(
                        isCorrect
                        ? AnyShapeStyle(
                            LinearGradient(
                                colors: [.orange, .pink, .yellow],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        : AnyShapeStyle(.orange)
                    )
                    .symbolEffect(.bounce, options: .repeating, isActive: isCorrect)
                    .accessibilityLabel(isCorrect ? "Yey, cita rasa baru kebaca" : "Petunjuk")

                VStack(spacing: 6) {
                    Text(isCorrect ? "Kamu mengenali cita rasa baru!" : "Hampir tepat!")
                        .font(.title.bold())
                    if isCorrect {
                        Text("Gitu dong—kamu baca nuansa, bukan cuma menebak label.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                }

                Text(message)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                if isCorrect {
                    if let nextAction = nextAction {
                        Button {
                            nextAction()
                        } label: {
                            Text("Lanjut Eksplorasi Rasa")
                                .bold()
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color.brown)
                        .controlSize(.large)
                    }
                } else {
                    NavigationLink {
                        TrainingView(
                            category: category,
                            stage: .taste,
                            onCloseEntireSheet: { dismiss() }
                        )
                    } label: {
                        Text("Ayo latihan rasa \(category.rawValue)")
                            .bold()
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.brown)
                    .controlSize(.large)
                }
                
                Button("Tutup") { dismiss() }
                    .foregroundStyle(.secondary)
            }
            .padding()
        }
    }
}

//#Preview {
//    NavigationStack {
//        ResultView(
//            evaluation: SensoryEvaluation(
//                beanName: "Ethiopia Yirgacheffe",
//                beanOrigin: "Ethiopia",
//                roastLevel: "Medium",
//                processLevel: "Natural",
//                fragranceIntensity: 7,
//                fragranceCategory: .nutty,
//                aromaContrast: .changed,
//                aromaIntensity: 8,
//                aromaCategory: .fruity,
//                acidity: 3,
//                sweetness: 2,
//                bitterness: 4,
//                bodyScore: 6
//            )
//        )
//    }
//}

private struct FragranceAromaSummaryCard: View {
    let fragranceCategory: FlavorCategory
    let fragranceIntensity: Double
    let aromaCategory: FlavorCategory
    let aromaIntensity: Double
    let aromaContrast: AromaContrast
    
    private var isBigContrast: Bool {
        aromaContrast == .changed || aromaCategory != fragranceCategory
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Fragrance → Aroma")
                    .font(.headline)
                Spacer()
                Text(isBigContrast ? "Kontras" : "Stabil")
                    .font(.caption.weight(.semibold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background((isBigContrast ? Color.orange : Color.green).opacity(0.12))
                    .foregroundStyle(isBigContrast ? .orange : .green)
                    .clipShape(Capsule())
            }
            
            HStack(spacing: 10) {
                summaryPill(title: "Dry", category: fragranceCategory, intensity: fragranceIntensity)
                Image(systemName: "arrow.right")
                    .foregroundStyle(.secondary)
                summaryPill(title: "Wet", category: aromaCategory, intensity: aromaIntensity)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.04), radius: 10, x: 0, y: 5)
    }
    
    private func summaryPill(title: String, category: FlavorCategory, intensity: Double) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption2)
                .foregroundStyle(.secondary)
            Text(category.rawValue)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.brown)
            Text("Intensity \(Int(intensity))/10")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}
