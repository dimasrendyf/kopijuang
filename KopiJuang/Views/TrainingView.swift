//
//  TrainingView.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 20/04/26.
//

import SwiftUI

import SwiftUI

struct TrainingView: View {
    @Environment(\.dismiss) var dismiss
    let flavor: String

    var body: some View {
        ScrollView { // Gunakan ScrollView biar aman di layar kecil
            VStack(spacing: 30) {
                
                // 1. Hero Image & Title Area (The Eye-Catcher)
                VStack(spacing: 16) {
                    Image(systemName: "hand.raised.square.on.square.fill") // Nanti ganti dengan Image("nama_asset_kamu")
                        .font(.system(size: 80)) // Jika pakai SF Symbol
                        // .resizable() // Jika pakai Image Asset
                        // .scaledToFit()
                        // .frame(height: 120)
                        .foregroundStyle(Color.brown)
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                    
                    VStack(spacing: 4) {
                        Text("Ayo kenali \(flavor)!")
                            .font(.title2.bold())
                            .multilineTextAlignment(.center)
                        
                        Text("Gapapa salah tebak, ini proses belajar.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.top)

                // 2. Training Method Area (Card-based)
                VStack(alignment: .leading, spacing: 16) {
                    Label("Siapkan \(flavor)", systemImage: "sparkles")
                        .font(.headline)
                        .foregroundStyle(.brown)
                    
                    Text("Jika punya \(flavor), potong kecil dan cium aromanya. Jika tidak, coba ingat rasa air perasan lemon.")
                        .font(.subheadline)
                        .lineSpacing(4)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(16)
                .padding(.horizontal)

                // 3. Steps Area (Structured List)
                VStack(alignment: .leading, spacing: 16) {
                    Text("Langkah Latihan:")
                        .font(.headline)
                    
                    TrainingStepRow(number: 1, text: "Cium referensi \(flavor).")
                    TrainingStepRow(number: 2, text: "Tahan rasa itu di memori lidahmu.")
                    TrainingStepRow(number: 3, text: "Icip kopimu lagi dengan teknik slurp.")
                }
                .padding(.horizontal)

                Spacer()
                
                // 4. Action Button (Full-width CTA)
                Button("Oke, aku sudah coba!") {
                    dismiss()
                }
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.brown)
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
    }
    
    // Helper function untuk gambar dinamis
    func imageForFlavor(_ flv: String) -> String {
        switch flv.lowercased() {
        case "fruity": return "jeruk/lemon"
        case "floral": return "bunga mawar"
        case "nutty": return "kacang/cokelat"
        default: return "referensi"
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
    TrainingView(flavor: "Citrus")
}
