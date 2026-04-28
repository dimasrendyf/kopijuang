//
//  FlavorDetailView.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 19/04/26.
//

import SwiftUI

struct FlavorDetailView: View {
    let flavor: FlavorNote
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header Visual
                ZStack {
                    Circle()
                        .fill(flavor.isUnlocked ? Color.brown.opacity(0.15) : Color.gray.opacity(0.15))
                        .frame(width: 120, height: 120)
                    
                    Image(systemName: flavor.isUnlocked ? flavor.icon : "lock.fill")
                        .font(.system(size: 50))
                        .foregroundColor(flavor.isUnlocked ? .brown : .gray)
                }
                .padding(.top, 20)
                
                // Title & Status
                VStack(spacing: 8) {
                    Text(flavor.isUnlocked ? flavor.name : "Terkunci")
                        .font(.largeTitle.bold())
                    
                    if flavor.isUnlocked {
                        Text("Level: \(flavor.familiarityLevel) • Pernah dirasakan \(flavor.experienceCount)x")
                            .font(.subheadline)
                            .foregroundStyle(Color.primary.opacity(0.72))
                    } else {
                        Text("Teruslah bereksplorasi untuk membuka notes ini.")
                            .font(.subheadline)
                            .foregroundStyle(Color.primary.opacity(0.72))
                    }
                }
                
                // Conditional Content
                if flavor.isUnlocked {
                    // --- UNLOCKED: Educational Content ---
                    VStack(alignment: .leading, spacing: 20) {
                        InfoCard(title: "Profil Rasa", content: flavor.description)
                        WCRSensoryTrainingView(guide: WCRSensoryTrainingData.guide(for: flavor.id))
                        InfoCard(title: "Tips Latihan", content: "Latih satu rasa per sesi. Bandingkan kopi saat panas dan hangat. Catat kata pertama yang muncul, bukan jawaban benar-salah.")
                    }
                    .padding()
                } else {
                    // --- LOCKED: Challenge Card ---
                    VStack(spacing: 16) {
                        Text("Cara Membuka:")
                            .font(.headline)
                        
                        Text("Coba seduh kopi dengan profil Natural atau origin Ethiopia. Kopi jenis ini punya potensi tinggi untuk mengeluarkan karakter \(flavor.name).")
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color.brown.opacity(0.1)))
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Component helper biar rapi
struct InfoCard: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.brown)
            Text(content)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
    }
}
