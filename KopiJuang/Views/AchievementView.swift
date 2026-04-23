//
//  AchievementView.swift
//  KopiJuang
//

import SwiftUI

struct AchievementView: View {
    let evaluation: SensoryEvaluation
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image(systemName: "medal.fill")
                .font(.system(size: 100))
                .foregroundStyle(
                    LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom)
                )
                .shadow(color: .orange.opacity(0.3), radius: 20, x: 0, y: 10)
            
            VStack(spacing: 12) {
                Text("Sensory Mastered!")
                    .font(.largeTitle.bold())
                
                Text("Kamu berhasil mengidentifikasi profil rasa dari kopi \(evaluation.beanName).")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 30)
            }
            
            VStack(spacing: 8) {
                Text("Notes yang kamu dapat:")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                HStack {
                    Text(evaluation.tasteCategory.rawValue)
                        .font(.headline)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color.brown.opacity(0.15))
                        .foregroundStyle(.brown)
                        .clipShape(Capsule())
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(20)
            .padding(.horizontal, 40)
            
            Spacer()
            
            Button {
                NavigationService.popToRootView()
            } label: {
                Text("Selesai & Kembali ke Dashboard")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.brown)
                    .foregroundStyle(.white)
                    .cornerRadius(16)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 20)
        }
        .navigationBarBackButtonHidden(true)
    }
}
