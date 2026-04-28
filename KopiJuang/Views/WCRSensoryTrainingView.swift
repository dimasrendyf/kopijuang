//
//  WCRSensoryTrainingView.swift
//  KopiJuang
//

import SwiftUI

struct WCRSensoryTrainingView: View {
    let guide: SensoryTrainingGuide

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Latihan indera", systemImage: "nose.fill")
                .font(.headline)
                .foregroundStyle(.brown)

            trainingRow(icon: "wind", title: "Cium", text: guide.smellTraining)
            trainingRow(icon: "mouth.fill", title: "Cicip", text: guide.tasteTraining)
            trainingRow(icon: "drop.fill", title: "Mouthfeel", text: guide.mouthTraining)
            trainingRow(icon: "repeat", title: "Drill", text: guide.dailyDrill)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.brown.opacity(0.18), lineWidth: 1)
        )
    }

    private func trainingRow(icon: String, title: String, text: String) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: icon)
                .font(.caption.bold())
                .foregroundStyle(.brown)
                .frame(width: 18)

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.caption.bold())
                    .textCase(.uppercase)
                    .foregroundStyle(Color.primary.opacity(0.65))
                Text(text)
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}
