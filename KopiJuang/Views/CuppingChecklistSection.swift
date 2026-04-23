//
//  CuppingChecklistSection.swift
//  Cek sebelum pengecapan: panduan praktik sensorik standar.
//

import SwiftUI

struct CuppingChecklistSection: View {
    @Binding var isExpanded: Bool

    private static let pages: [(icon: String, title: String, detail: String)] = [
        (
            "gearshape.2.fill",
            "Seduh & Giling",
            "Gunakan suhu air ideal (sekitar 92–96°C). Pastikan konsistensi ukuran gilingan: gilingan yang terlalu halus memicu pahit berlebih, sementara gilingan terlalu kasar menghasilkan kopi yang encer dengan intensitas aroma rendah."
        ),
        (
            "drop.circle.fill",
            "Bersihkan Lidah",
            "Bilas lidah dengan air putih sebelum memulai. Menjaga kebersihan indra perasa membantu Anda menangkap nuansa rasa yang halus—terutama pada karakteristik asam atau fermentasi—dengan lebih akurat."
        ),
        (
            "thermometer.medium",
            "Waktu Mencicip",
            "Hindari mencicip saat kopi terlalu panas agar indra perasa tidak mati rasa. Biarkan suhu turun secara bertahap; aroma dan profil rasa akan lebih jelas terbaca saat suhu kopi hangat dan nyaman di lidah."
        ),
        (
            "mouth.fill",
            "Slurp & Retronasal",
            "Lakukan *slurp* untuk menyebarkan kopi ke seluruh permukaan lidah, lalu hembuskan napas secara retronasal. Fokuslah mendeskripsikan profil rasa terlebih dahulu sebelum memberikan penilaian skor."
        )
    ]

    var body: some View {
        Section {
            DisclosureGroup(isExpanded: $isExpanded) {
                TabView {
                    ForEach(Array(Self.pages.enumerated()), id: \.offset) { _, page in
                        VStack(spacing: 14) {
                            Image(systemName: page.icon)
                                .font(.system(size: 44))
                                .foregroundStyle(.brown)
                            Text(page.title)
                                .font(.headline)
                            Text(page.detail)
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.horizontal, 12)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 12)
                        .padding(.bottom, 36)
                    }
                }
                .frame(height: 320)
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            } label: {
                Label("Checklist sebelum cupping", systemImage: "checklist")
                    .font(.headline)
            }
        } footer: {
            Text("Panduan ini disesuaikan dengan praktik pengecapan standar. Silakan sesuaikan kembali dengan parameter alat, rasio, dan metode seduh Anda.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
