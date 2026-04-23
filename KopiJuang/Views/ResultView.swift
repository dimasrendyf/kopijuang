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

    let evaluation: SensoryEvaluation
    
    // State untuk feedback
    @State private var showingFeedback = false
    @State private var isCorrect = true
    @State private var feedbackMessage = ""
    @State private var selectedCategory: FlavorCategory?
    @State private var showDiscovery = false
    
    // For navigation
    @State private var navigateToCascading = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // 0. Session Meta
                VStack(alignment: .leading, spacing: 8) {
                    Text(evaluation.beanName)
                        .font(.title2.bold())
                    HStack(spacing: 8) {
                        Text(evaluation.beanOrigin)
                        Text("•")
                        Text("Roast \(evaluation.roastLevel)")
                        Text("•")
                        Text(evaluation.processLevel)
                    }
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
                        SensoryBar(label: "Asam", value: evaluation.acidity, max: 10)
                        SensoryBar(label: "Manis", value: evaluation.sweetness, max: 10)
                        SensoryBar(label: "Pahit", value: evaluation.bitterness, max: 10)
                        SensoryBar(label: "Body", value: evaluation.bodyScore, max: 10)
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
                    
                    Text(brewTipInsight)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.primary)
                    
                    Text(brewTipAction)
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
                                checkAnswer(category)
                            }
                            .overlay(
                                Image(systemName: selectedCategory == category ? "checkmark.circle.fill" : "circle")
                                    .font(.title3)
                                    .foregroundStyle(selectedCategory == category ? .brown : .secondary)
                                    .padding(12),
                                alignment: .topTrailing
                            )
                        }
                    }

                    Button {
                        showDiscovery = true
                    } label: {
                        Text("Aku gak yakin, bantu discovery notes")
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
        .sheet(isPresented: $showingFeedback) {
            FeedbackView(
                isCorrect: isCorrect,
                message: feedbackMessage,
                category: selectedCategory ?? .fruity,
                nextAction: {
                    showingFeedback = false
                    // Give sheet time to dismiss before navigating
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        navigateToCascading = true
                    }
                }
            )
        }
        .navigationDestination(isPresented: $navigateToCascading) {
            if let cat = selectedCategory {
                CascadingQuizView(
                    evaluation: evaluation,
                    selectedPrimaryCategory: cat,
                    parentNodeId: cat.rawValue
                )
            }
        }
        .sheet(isPresented: $showDiscovery) {
            NavigationStack {
                DiscoveryNotesView(stage: .taste)
            }
        }
    }

    private var brewTipInsight: String {
        let roast = evaluation.roastLevel.lowercased()
        let process = evaluation.processLevel.lowercased()
        
        if evaluation.bitterness >= 8 && roast == "dark" {
            return "Pahit dominan kemungkinan dari profil roast + ekstraksi."
        }
        if evaluation.acidity >= 8 && roast == "light" {
            return "Keasaman terasa cukup agresif untuk profil light roast."
        }
        if evaluation.sweetness <= 4 && (process == "natural" || process == "honey") {
            return "Manis alami dari process belum keluar maksimal."
        }
        if evaluation.bodyScore <= 4 {
            return "Body terasa tipis, kemungkinan ekstraksi masih kurang."
        }
        
        return "Cup kamu sudah cukup seimbang untuk parameter saat ini."
    }
    
    private var brewTipAction: String {
        let roast = evaluation.roastLevel.lowercased()
        let process = evaluation.processLevel.lowercased()
        
        if evaluation.bitterness >= 8 && roast == "dark" {
            return "Coba turunkan suhu ke 88-90C atau percepat waktu seduh."
        }
        if evaluation.acidity >= 8 && roast == "light" {
            return "Coba gilingan sedikit lebih halus agar ekstraksi lebih seimbang."
        }
        if evaluation.sweetness <= 4 && (process == "natural" || process == "honey") {
            return "Coba rasio sedikit lebih pekat atau naikkan suhu 1-2C."
        }
        if evaluation.bodyScore <= 4 {
            return "Coba grind sedikit lebih halus atau tambah waktu kontak 10-15 detik."
        }
        
        return "Pertahankan resep ini lalu ubah 1 variabel kecil saja di sesi berikutnya."
    }
    
    func checkAnswer(_ category: FlavorCategory) {
        selectedCategory = category
        isCorrect = true
        feedbackMessage = "\(category.rawValue) itu luas. Yuk lanjut, rasa turunan apa yang paling mendekati kopimu?"

        let progress = UserProgressStore.primary(from: userProgresses, in: modelContext)
        if !progress.unlockedPrimaryNotes.contains(category.rawValue) {
            progress.unlockedPrimaryNotes.append(category.rawValue)
        }
        progress.appendExperiencedNote(category.rawValue)
        do {
            try modelContext.save()
        } catch {
            print("Failed saving ResultView progress: \(error.localizedDescription)")
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
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(accentColor(category).opacity(0.18))
                        .frame(width: 44, height: 44)
                    Image(systemName: iconForCategory(category))
                        .font(.title3.weight(.semibold))
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(category.rawValue)
                        .font(.headline)
                    Text(descriptionForCategory(category))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
                Spacer(minLength: 0)
            }
            .foregroundStyle(accentColor(category))
            .padding(.vertical, 14)
            .padding(.horizontal, 14)
            .background(
                LinearGradient(
                    colors: [accentColor(category).opacity(0.16), accentColor(category).opacity(0.06)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(accentColor(category).opacity(0.35), lineWidth: 1)
            )
        }
    }
    
    private func accentColor(_ cat: FlavorCategory) -> Color {
        switch cat {
        case .floral: return .teal
        case .fruity: return .orange
        case .nutty: return .brown
        case .sweet: return .pink
        }
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
            return "Nuansa bunga/teh lewat aroma retronasal."
        case .fruity:
            return "Karakter buah yang fresh dan cerah."
        case .nutty:
            return "Kacang/cokelat hangat yang membumi."
        case .sweet:
            return "Manis alami yang bikin cup terasa round."
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
                Image(systemName: isCorrect ? "star.fill" : "lightbulb.fill")
                    .font(.system(size: 80))
                    .foregroundStyle(isCorrect ? .yellow : .orange)

                Text(isCorrect ? "Brilliant!" : "Hampir tepat!")
                    .font(.title.bold())
                
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
