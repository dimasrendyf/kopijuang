//
//  CuppingChecklistSection.swift
//  Cek sebelum pengecapan: parafase praktik piala umum, tanpa klaim label resmi pihak ketiga.
//

import SwiftUI

struct CuppingChecklistSection: View {
    @Binding var isExpanded: Bool

    private static let pages: [(icon: String, title: String, detail: String)] = [
        (
            "gearshape.2.fill",
            "Brewing & giling",
            "Air ~92–96°C sesuai resep, giling konsisten. Terlalu halus: risiko pahit berlebih; terlalu kasar: cair encer, aroma sulit dibangun."
        ),
        (
            "drop.circle.fill",
            "Palat netral",
            "Teguk air sebelum cicip agar sisa rasa tadi tidak mengganggu. Palat jernih menolong beda tajam tipis, terutama fase asam/ferment."
        ),
        (
            "thermometer.medium",
            "Jendela suhu icip",
            "Setelah dituang, cicip saat cairan turun ke kisaran netral cukup panas di mulut; terlalu panas mematikan sensasi, terlalu dingin menutup uap."
        ),
        (
            "mouth.fill",
            "Slurp & retronasal",
            "Seruput agar cairan menyebar di lidah; aroma naik retronasal. Latihan fokus: aroma vs rasa, bukan skor dulu."
        )
    ]

    var body: some View {
        Section {
            DisclosureGroup(isExpanded: $isExpanded) {
                TabView {
                    ForEach(Array(Self.pages.enumerated()), id: \.offset) { _, page in
                        VStack(spacing: 16) {
                            Spacer(minLength: 0)
                            Image(systemName: page.icon)
                                .font(.system(size: 48))
                                .foregroundStyle(.brown)
                            Text(page.title)
                                .font(.headline)
                            Text(page.detail)
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.secondary)
                                .padding(.horizontal, 8)
                            Spacer(minLength: 0)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.vertical, 8)
                    }
                }
                .frame(height: 220)
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            } label: {
                Label("Checklist sebelum cupping", systemImage: "checklist")
                    .font(.headline)
            }
        } footer: {
            Text("Disarankan sesuai praktik pengecapan; sesuaikan alat, rasio, dan resep pribadimu.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
