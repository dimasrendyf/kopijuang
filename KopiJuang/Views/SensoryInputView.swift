//
//  SensoryInputView.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 19/04/26.
//

import SwiftUI

struct SensoryInputView: View {
    @State private var tastes: [Taste] = [
        Taste(name: "Asam", value: 2),
        Taste(name: "Manis", value: 2),
        Taste(name: "Kekentalan", value: 2),
        Taste(name: "Aftertaste", value: 2)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    Text("Apa rasa kopi yang kamu rasakan?")
                        .font(.title2.bold())
                        .multilineTextAlignment(.center)
                        .padding(.top)
                    
                    // 2. Loop Component
                    VStack(spacing: 24) {
                        ForEach($tastes) { $taste in
                            SensorySliderView(taste: $taste)
                        }
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(20)
                    .padding(.horizontal)
                    
                    NavigationLink(destination: ResultView()) {
                        Text("Lihat Hasil")
                            .font(.headline)
                            .padding()
                            .background(Color.brown)
                            .foregroundStyle(.white)
                            .cornerRadius(12)
                    }
                }
            }
            .navigationTitle("Sensory")
        }
    }
}

struct SensorySliderView: View {
    @Binding var taste: Taste
    private let impact = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(taste.name)
                    .font(.headline)
                Spacer()
                Text("\(Int(taste.value)) / 4")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Slider(value: $taste.value, in: 1...4, step: 1) { _ in
                impact.impactOccurred() // Feedback fisik
            }
            .tint(.brown)
            
            HStack {
                Text("Rendah").font(.caption2)
                Spacer()
                Text("Tinggi").font(.caption2)
            }
            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    SensoryInputView()
}
