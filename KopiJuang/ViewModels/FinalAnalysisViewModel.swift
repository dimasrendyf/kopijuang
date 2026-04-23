//
//  FinalAnalysisViewModel.swift
//  KopiJuang
//

import Foundation
import Observation

@MainActor
@Observable
final class FinalAnalysisViewModel {
    let evaluation: SensoryEvaluation
    let primaryCategory: FlavorCategory
    let selectedNode: FlavorWheelNode?

    init(
        evaluation: SensoryEvaluation,
        primaryCategory: FlavorCategory,
        selectedNode: FlavorWheelNode?
    ) {
        self.evaluation = evaluation
        self.primaryCategory = primaryCategory
        self.selectedNode = selectedNode
    }

    var secondaryNote: String? {
        guard let node = selectedNode else { return nil }
        if node.layer == 2 { return node.name }
        if node.layer == 3, let parentId = node.parent {
            return FlavorWheelNode.findNode(by: parentId)?.name
        }
        return nil
    }

    var specificNote: String? {
        guard let node = selectedNode, node.layer == 3 else { return nil }
        return node.name
    }

    var certaintyMessage: String {
        if evaluation.aromaContrast == .unsure {
            return "Wajar kalau tadi kamu sempat belum yakin membedakan dry dan wet aroma. Itu bagian normal dari latihan sensory. Kamu tetap berhasil memilih profil yang paling mendekati pengalamanmu."
        }
        return "Pilihanmu konsisten dengan alur sensory yang kamu isi. Mantap, ini langkah bagus untuk membangun memori rasa."
    }

    var spotlightMessage: String {
        if let secondaryNote, let specificNote {
            return "Kamu memilih profil \(primaryCategory.rawValue) dengan turunan \(secondaryNote) dan note spesifik \(specificNote). Selamat, kamu sudah masuk level eksplorasi detail."
        }
        if let secondaryNote {
            return "Kamu memilih profil \(primaryCategory.rawValue) dengan turunan \(secondaryNote). Ini sudah menunjukkan kamu mulai peka ke detail rasa."
        }
        return "Kamu memilih profil \(primaryCategory.rawValue). Selamat ya, kamu berhasil mengenali karakter utama dari cangkir ini."
    }

    var brewGuidance: String {
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

    func selectedNoteExperienceCount(from userProgresses: [UserProgress]) -> Int {
        guard let selectedNode else { return 0 }
        let experienced = userProgresses.flatMap(\.allExperiencedNotes)
        return experienced.filter { $0 == selectedNode.name }.count
    }

    func familiarityLevel(experienceCount: Int) -> String {
        switch experienceCount {
        case 0, 1...2: "Pemula"
        case 3...5: "Kenal"
        case 6...9: "Akrab"
        default: "Peka"
        }
    }

}
