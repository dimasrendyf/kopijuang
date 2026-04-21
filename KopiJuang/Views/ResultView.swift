//
//  ResultView.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 20/04/26.
//

import SwiftUI

// MARK: - Model
enum FlavorCategory: String, CaseIterable {
    case fruity = "Fruity"
    case floral = "Floral"
    case nutty = "Nutty"
}

// MARK: - Main View
struct ResultView: View {
    // Hasil sensorik
    let acidity: Double = 3.2
    let sweetness: Double = 2.8
    let bodyValue: Double = 3.5
    
    // State untuk feedback
    @State private var showingFeedback = false
    @State private var isCorrect = false
    @State private var feedbackMessage = ""
    
    // "Truth" (Nanti ini bisa di-generate dari logic/mapper)
    let correctCategory: FlavorCategory = .fruity

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // 1. Report Area (Card-based)
                VStack(alignment: .leading, spacing: 16) {
                    Text("Analisis Sensorik")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    
                    VStack(spacing: 12) {
                        SensoryBar(label: "Asam", value: acidity, max: 4)
                        SensoryBar(label: "Manis", value: sweetness, max: 4)
                        SensoryBar(label: "Kekentalan", value: bodyValue, max: 4)
                    }
                }
                .padding(24)
                .background(Color(.systemBackground))
                .cornerRadius(24)
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
                .padding(.horizontal)
                .padding(.top, 10)

                // 2. Question Section
                VStack(spacing: 16) {
                    Text("Menurut lidahmu, ini rasa apa?")
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
        case .floral: return "leaf.arrow.trianglehead.clockwise"
        case .nutty: return "circle.grid.3x3.fill"
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
        ResultView()
    }
}
