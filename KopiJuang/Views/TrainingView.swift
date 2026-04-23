//
//  TrainingView.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 20/04/26.
//

import SwiftUI

struct TrainingView: View {
    @Environment(\.dismiss) var dismiss
    let flavor: String
    var stage: DiscoveryStage = .taste

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
                        
                        Text(stageSubtitle)
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
                    
                    Text(trainingPrompt)
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
                    
                    TrainingStepRow(number: 1, text: stageSteps[0])
                    TrainingStepRow(number: 2, text: stageSteps[1])
                    TrainingStepRow(number: 3, text: stageSteps[2])
                }
                .padding(.horizontal)

                Spacer()
                
                // 4. Action Buttons (Full-width CTA)
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
                        NavigationUtil.popToRootView()
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
    
    private var stageSubtitle: String {
        switch stage {
        case .fragrance:
            return "Gapapa kalau masih bingung. Yuk latih hidungmu dulu di tahap fragrance."
        case .aroma:
            return "Wajar kalau dry dan wet kadang mirip. Yuk latih pembacaan aroma bloom."
        case .taste:
            return "Gapapa salah tebak, ini proses belajar rasa di lidah."
        }
    }

    private var trainingPrompt: String {
        switch stage {
        case .fragrance:
            return "Siapkan referensi \(flavor) lalu cium dalam kondisi kering. Fokus di hidung, jangan buru-buru menilai rasa."
        case .aroma:
            return "Siapkan referensi \(flavor), lalu bandingkan aromanya setelah kontak air panas. Tujuannya melatih transisi dry ke wet."
        case .taste:
            return "Siapkan referensi \(flavor). Jika tidak ada, gunakan ingatan rasa yang mirip untuk bantu kalibrasi saat menyeruput."
        }
    }

    private var stageSteps: [String] {
        switch stage {
        case .fragrance:
            return [
                "Cium referensi \(flavor) dalam kondisi kering.",
                "Sebutkan 1-2 kata kunci aromanya (misal segar, manis, kacang).",
                "Cium bubuk kopimu lagi dan bandingkan."
            ]
        case .aroma:
            return [
                "Cium referensi \(flavor), lalu cium kopi saat wet/bloom.",
                "Catat apakah aroma jadi lebih jelas atau berubah.",
                "Bandingkan lagi dengan fase dry untuk lihat kontras."
            ]
        case .taste:
            return [
                "Cium atau icip referensi \(flavor) untuk kalibrasi cepat.",
                "Tahan sensasi itu di memori lidahmu.",
                "Icip kopimu lagi dengan teknik slurp."
            ]
        }
    }
    
    // Helper function untuk gambar dinamis
    func imageForFlavor(_ flv: String) -> String {
        switch flv.lowercased() {
        case "fruity": return "jeruk/lemon"
        case "floral": return "bunga mawar"
        case "nutty": return "kacang/cokelat"
        case "sweet": return "gula/madu"
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
    TrainingView(flavor: "Citrus", stage: .taste)
}
