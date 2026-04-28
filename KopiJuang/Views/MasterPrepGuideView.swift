//
//  MasterPrepGuideView.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 19/04/26.
//

import SwiftUI

struct MasterPrepGuideView: View {
    @AppStorage("hasCompletedFirstSession") var hasCompletedFirstSession: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var isFirstRun: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                TabView {
                    // Page 1: Brew & Grind
                    GuidePageView(
                        icon: "gearshape.2.fill",
                        title: "Brewing & Grind",
                        description: "Suhu seduh ideal 92-96°C. Gunakan gilingan Medium (seperti gula pasir). Terlalu halus akan pahit (over-extracted), terlalu kasar akan encer (under-extracted)."
                    )
                    
                    // Page 2: Clean Palate
                    GuidePageView(
                        icon: "drop.circle.fill",
                        title: "Reset Lidah",
                        description: "Sesuai protokol WCR, teguk air putih sebelum mulai untuk menghilangkan residu rasa sebelumnya. Lidah netral adalah kunci akurasi."
                    )
                    
                    // Page 3: Temperature
                    GuidePageView(
                        icon: "thermometer.medium",
                        title: "Sensory Window",
                        description: "Waktu terbaik icip adalah saat suhu kopi turun ke 50-60°C. Reseptor manis dan asam di lidah mencapai sensitivitas puncak di suhu ini."
                    )
                    
                    // Page 4: The Slurp
                    GuidePageView(
                        icon: "mouth.fill",
                        title: "Teknik Slurp",
                        description: "Seruput kopi dengan keras (aerasi). Ini menyebarkan kopi ke seluruh lidah dan mendorong aroma ke rongga belakang hidung (retro-nasal olfaction)."
                    )
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                if isFirstRun {
                    Button(action: {
                        hasCompletedFirstSession = true
                    }) {
                        Text("Rasain Kopimu")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.brown)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle("Tips Barista")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if !isFirstRun {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title3)
                        }
                    }
                }
            }
        }
    }
}

struct GuidePageView: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: icon)
                .font(.system(size: 80))
                .foregroundColor(.brown)
            
            Text(title)
                .font(.title2.bold())
            
            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .foregroundStyle(Color.primary.opacity(0.72))
            Spacer()
        }
        .padding()
    }
}

#Preview {
    MasterPrepGuideView(isFirstRun: true)
}
