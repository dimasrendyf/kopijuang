//
//  ResultView.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 20/04/26.
//

import SwiftUI

// MARK: - Main View
struct ResultView: View {
    let evaluation: SensoryEvaluation
    
    // State untuk feedback
    @State private var showingFeedback = false
    @State private var isCorrect = false
    @State private var feedbackMessage = ""
    
    private var correctCategory: FlavorCategory { evaluation.aromaCategory }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // 0. Session Meta
                VStack(alignment: .leading, spacing: 8) {
                    Text(evaluation.beansName)
                        .font(.title2.bold())
                    Text("Grind: \(evaluation.grindSize)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 10)
                
                // 0.5 Fragrance vs Aroma
                FragranceAromaSummaryCard(
                    fragranceCategory: evaluation.fragranceCategory,
                    fragranceIntensity: evaluation.fragranceIntensity,
                    aromaCategory: evaluation.aromaCategory,
                    aromaIntensity: evaluation.aromaIntensity,
                    aromaContrast: evaluation.aromaContrast
                )
                .padding(.horizontal)
                
                // 1. Report Area (Card-based)
                VStack(alignment: .leading, spacing: 16) {
                    Text("Analisis Sensorik")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    
                    VStack(spacing: 12) {
                        SensoryBar(label: "Asam", value: evaluation.acidity, max: 4)
                        SensoryBar(label: "Manis", value: evaluation.sweetness, max: 4)
                        SensoryBar(label: "Kekentalan", value: evaluation.mouthfeel, max: 4)
                        SensoryBar(label: "Aftertaste", value: evaluation.aftertaste, max: 4)
                    }
                    
                    HStack {
                        Text("Aftertaste Duration")
                            .font(.subheadline.weight(.semibold))
                        Spacer()
                        Text("\(Int(evaluation.aftertasteDuration)) / 5")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.brown)
                    }
                }
                .padding(24)
                .background(Color(.systemBackground))
                .cornerRadius(24)
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
                .padding(.horizontal)

                // 2. Question Section
                VStack(spacing: 16) {
                    Text("Kategori dominan apa yang paling kamu rasakan saat diseruput?")
                        .font(.title3.bold())
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        ForEach(FlavorCategory.allCases, id: \.self) { category in
                            CategoryButton(category: category) {
                                checkAnswer(category)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color(.secondarySystemBackground))
        .navigationTitle("Hasil Analisis")
        .sheet(isPresented: $showingFeedback) {
            FeedbackView(isCorrect: isCorrect, message: feedbackMessage, category: correctCategory)
        }
    }

    func checkAnswer(_ category: FlavorCategory) {
        if category == correctCategory {
            isCorrect = true
            feedbackMessage = "Tepat sekali! Kamu punya indera perasa yang tajam. Badge \(category.rawValue) berhasil didapatkan!"
        } else {
            isCorrect = false
            feedbackMessage = "Hmm, menarik! Tapi sebenarnya profil ini lebih condong ke \(correctCategory.rawValue). Mau coba latihan referensi rasa \(correctCategory.rawValue)?"
        }
        showingFeedback = true
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
            VStack(spacing: 8) {
                Image(systemName: iconForCategory(category))
                    .font(.title2)
                Text(category.rawValue)
                    .font(.subheadline.bold())
                Text(descriptionForCategory(category))
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(Color.brown.opacity(0.1))
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.brown.opacity(0.3), lineWidth: 1))
        }
        .foregroundStyle(.brown)
    }
    
    func iconForCategory(_ cat: FlavorCategory) -> String {
        switch cat {
        case .fruity: return "leaf.fill"
        case .floral: return "sparkles"
        case .nutty: return "circle.grid.3x3.fill"
        case .sweet: return "cube.fill"
        }
    }
    
    func descriptionForCategory(_ cat: FlavorCategory) -> String {
        switch cat {
        case .floral:
            return "Aroma bunga/teh via retronasal (jasmine, black tea)."
        case .fruity:
            return "Buah + acidity rapi (citrus, berry)."
        case .nutty:
            return "Kacang/cocoa “brown” hangat (almond, cocoa)."
        case .sweet:
            return "Manis sebagai roundness (honey, vanilla, caramel)."
        }
    }
}

// MARK: - Feedback View
struct FeedbackView: View {
    @Environment(\.dismiss) var dismiss
    let isCorrect: Bool
    let message: String
    let category: FlavorCategory

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Image(systemName: isCorrect ? "star.fill" : "lightbulb.fill")
                    .font(.system(size: 80))
                    .foregroundStyle(isCorrect ? .yellow : .orange)

                Text(isCorrect ? "Brilliant!" : "Hampir tepat!")
                    .font(.title.bold())
                
                Text(message)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                if !isCorrect {
                    NavigationLink(destination: TrainingView(flavor: category.rawValue)) {
                        Text("Ayo Latihan Rasa \(category.rawValue)")
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

#Preview {
    NavigationStack {
        ResultView(
            evaluation: SensoryEvaluation(
                beansName: "Ethiopia Yirgacheffe",
                grindSize: "Medium",
                packagingNotes: "",
                fragranceIntensity: 7,
                fragranceCategory: .nutty,
                aromaContrast: .changed,
                aromaIntensity: 8,
                aromaCategory: .fruity,
                acidity: 3,
                sweetness: 2,
                mouthfeel: 3,
                aftertaste: 3,
                aftertasteDuration: 4
            )
        )
    }
}

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
