//
//  SessionHistoryDetailView.swift
//  Riwayat: detail sesi & ringkasan sensorik tersimpan.
//

import SwiftUI

struct SessionHistoryDetailView: View {
    let session: SessionHistory

    private var dateText: String {
        session.date.formatted(date: .long, time: .shortened)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let s = session.decodedSnapshot {
                    fullDetail(snapshot: s)
                } else {
                    legacySessionView
                }
            }
            .padding()
        }
        .background(Color(.secondarySystemBackground))
        .navigationTitle(session.beanName)
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private var legacySessionView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Sesi lama (sebelum detail penuh)")
                .font(.headline)
            Text("Hanya tersimpan: bean, roast, proses, kategori L1. Sesi setelah update menyimpan skor penuh.")
                .font(.subheadline)
                .foregroundStyle(Color.primary.opacity(0.72))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)

        metaBlock(title: "Tanggal", value: dateText)
        metaBlock(title: "Roast", value: session.roastLevel)
        metaBlock(title: "Proses", value: session.processLevel)
        metaBlock(title: "Kategori L1", value: session.finalCategory)
    }

    @ViewBuilder
    private func fullDetail(snapshot: SessionSnapshot) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Ringkasan sesi")
                .font(.title2.bold())
            Text(dateText)
                .font(.subheadline)
                .foregroundStyle(Color.primary.opacity(0.72))
        }
        .frame(maxWidth: .infinity, alignment: .leading)

        VStack(alignment: .leading, spacing: 12) {
            Text("Beans")
                .font(.headline)
            metaRow(title: "Nama", value: snapshot.beanName)
            metaRow(title: "Origin", value: snapshot.beanOrigin)
            metaRow(title: "Roast", value: snapshot.roastLevel)
            metaRow(title: "Proses", value: snapshot.processLevel)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(16)

        VStack(alignment: .leading, spacing: 10) {
            Text("Fragrance & Aroma")
                .font(.headline)
            Text("Saat kering: \(snapshot.fragranceCategory) — kekuatan \(Int(snapshot.fragranceIntensity))/10")
                .font(.subheadline)
            Text("Setelah air masuk: \(snapshot.aromaCategory) — kekuatan \(Int(snapshot.aromaIntensity))/10")
                .font(.subheadline)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(16)

        VStack(alignment: .leading, spacing: 10) {
            Text("Rasa kopi")
                .font(.headline)
            SensoryBar(label: "Asam", value: snapshot.acidity, max: 10)
            SensoryBar(label: "Manis", value: snapshot.sweetness, max: 10)
            SensoryBar(label: "Pahit", value: snapshot.bitterness, max: 10)
            SensoryBar(label: "Body", value: snapshot.bodyScore, max: 10)
            Text("Dominan notes: \(snapshot.tasteCategory)")
                .font(.subheadline)
                .padding(.top, 4)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(16)

        VStack(alignment: .leading, spacing: 8) {
            Text("Eksplorasi wheel")
                .font(.headline)
            if let p = FlavorCategory(rawValue: snapshot.primaryCategory) {
                Label(snapshot.primaryCategory, systemImage: p.categoryIconName)
                    .font(.subheadline.weight(.semibold))
            } else {
                Text(snapshot.primaryCategory)
                    .font(.subheadline.weight(.semibold))
            }
            if let sec = snapshot.secondaryNote {
                Text("Turunan: \(sec)")
                    .font(.subheadline)
            }
            if let sp = snapshot.specificNote {
                Text("Spesifik: \(sp)")
                    .font(.subheadline)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)

        VStack(alignment: .leading, spacing: 10) {
            Text("Saran untuk seduhan berikutnya")
                .font(.headline)
            Text(BrewHeuristics.nextBrewGuidance(for: snapshot.toSensoryEvaluation()))
                .font(.subheadline)
                .foregroundStyle(Color.primary.opacity(0.72))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
    }

    private func metaBlock(title: String, value: String) -> some View {
        HStack(alignment: .top) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(Color.primary.opacity(0.72))
            Spacer()
            Text(value)
                .font(.subheadline.weight(.semibold))
                .multilineTextAlignment(.trailing)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }

    private func metaRow(title: String, value: String) -> some View {
        HStack(alignment: .top) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(Color.primary.opacity(0.72))
            Spacer()
            Text(value)
                .font(.subheadline.weight(.semibold))
                .multilineTextAlignment(.trailing)
        }
    }
}

#Preview {
    NavigationStack {
        SessionHistoryDetailView(
            session: SessionHistory(
                beanName: "Test",
                roastLevel: "Light",
                processLevel: "Wash",
                finalCategory: "Fruity"
            )
        )
    }
}
