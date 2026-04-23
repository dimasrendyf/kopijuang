//
//  FinalAnalysisView.swift
//  KopiJuang
//

import SwiftUI

struct FinalAnalysisView: View {
    let evaluation: SensoryEvaluation
    let primaryCategory: FlavorCategory
    let selectedNode: FlavorWheelNode?

    private var secondaryNote: String? {
        guard let node = selectedNode else { return nil }
        if node.layer == 2 { return node.name }
        if node.layer == 3, let parentId = node.parent {
            return FlavorWheelNode.findNode(by: parentId)?.name
        }
        return nil
    }

    private var specificNote: String? {
        guard let node = selectedNode, node.layer == 3 else { return nil }
        return node.name
    }

    private var certaintyMessage: String {
        if evaluation.aromaContrast == .unsure {
            return "Wajar kalau tadi kamu sempat belum yakin membedakan dry dan wet aroma. Itu bagian normal dari latihan sensory. Kamu tetap berhasil memilih profil yang paling mendekati pengalamanmu."
        }
        return "Pilihanmu konsisten dengan alur sensory yang kamu isi. Mantap, ini langkah bagus untuk membangun memori rasa."
    }

    private var spotlightMessage: String {
        if let secondaryNote, let specificNote {
            return "Kamu memilih profil \(primaryCategory.rawValue) dengan turunan \(secondaryNote) dan note spesifik \(specificNote). Selamat, kamu sudah masuk level eksplorasi detail."
        }
        if let secondaryNote {
            return "Kamu memilih profil \(primaryCategory.rawValue) dengan turunan \(secondaryNote). Ini sudah menunjukkan kamu mulai peka ke detail rasa."
        }
        return "Kamu memilih profil \(primaryCategory.rawValue). Selamat ya, kamu berhasil mengenali karakter utama dari cangkir ini."
    }

    private var brewGuidance: String {
        let roast = evaluation.roastLevel.lowercased()
        let process = evaluation.processLevel.lowercased()

        if evaluation.aromaContrast == .unsure {
            return "Untuk sesi berikutnya, coba jeda 15-20 detik antara cium dry dan wet lalu catat 1 kata kunci tiap fase. Teknik ini biasanya bantu mengurangi rasa ragu."
        }
        if evaluation.bitterness >= 8 && roast == "dark" {
            return "Pahit dominan dari profil dark roast + ekstraksi. Besok coba turunkan suhu ke 88-90C."
        }
        if evaluation.acidity >= 8 && roast == "light" {
            return "Keasaman cukup tajam. Besok coba grind sedikit lebih halus agar ekstraksi lebih seimbang."
        }
        if evaluation.sweetness <= 4 && (process == "natural" || process == "honey") {
            return "Manis alami belum keluar maksimal. Besok coba rasio sedikit lebih pekat."
        }
        return "Cup kamu sudah cukup balance. Besok ubah satu variabel kecil saja (rasio/suhu/grind) agar progres belajar terasa jelas."
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                VStack(spacing: 8) {
                    Text("Hasil Analisis Final")
                        .font(.title2.bold())
                    Text("Ringkasan akhir setelah kamu memilih profil rasa sampai layer terluar.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 8)

                FinalCard(title: "Highlight Profil") {
                    Text(spotlightMessage)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                FinalCard(title: "Status Keyakinan") {
                    Text(certaintyMessage)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                FinalCard(title: "Profil Akhir") {
                    VStack(alignment: .leading, spacing: 8) {
                        profileChip(text: primaryCategory.rawValue)
                        if let secondaryNote {
                            profileChip(text: secondaryNote)
                        }
                        if let specificNote {
                            profileChip(text: specificNote)
                        }
                    }
                }

                FinalCard(title: "Saran Next Seduhan") {
                    Text(brewGuidance)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Button {
                    NavigationUtil.popToRootView()
                } label: {
                    Text("Selesai & Kembali ke Dashboard")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.brown)
                        .foregroundStyle(.white)
                        .cornerRadius(14)
                }
                .padding(.top, 6)
            }
            .padding()
        }
        .background(Color(.secondarySystemBackground))
        .navigationBarBackButtonHidden(true)
    }

    private func profileChip(text: String) -> some View {
        Text(text)
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.brown)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(Color.brown.opacity(0.12))
            .clipShape(Capsule())
    }
}

private struct FinalCard<Content: View>: View {
    let title: String
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.brown)
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
    }
}
