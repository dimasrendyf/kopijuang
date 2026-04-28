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

    /// Menggantikan "keyakinan": ringkas data yang sudah diisi (bukan opini generik).
    var flowDataSummary: String {
        var parts: [String] = []
        parts.append(
            "Kopi: \(evaluation.beanName) · \(evaluation.beanOrigin). Seduh: \(evaluation.roastLevel), \(evaluation.processLevel)."
        )
        parts.append(
            "Kering: \(evaluation.fragranceCategory.rawValue) (int. \(Int(evaluation.fragranceIntensity))). Basah: \(evaluation.aromaCategory.rawValue) (int. \(Int(evaluation.aromaIntensity))), kontras: \(evaluation.aromaContrast.rawValue)."
        )
        parts.append(
            "Kesan taste (slurp): asam \(Int(evaluation.acidity)), manis \(Int(evaluation.sweetness)), pahit \(Int(evaluation.bitterness)), body \(Int(evaluation.bodyScore)), dominan peta \(evaluation.tasteCategory.rawValue)."
        )
        if evaluation.aromaContrast == .unsure {
            parts.append("Kamu tandai “gak yakin” pada kontras dry–wet: wajar. Di sesi berikutnya, coba satu kata kunci per fase sebelum skor penuh.")
        }
        if evaluation.fragranceCategory == evaluation.tasteCategory {
            parts.append("Arah fragrance dan taste kategori L1 selaras (\(evaluation.fragranceCategory.rawValue)).")
        } else {
            parts.append("Fragrance \(evaluation.fragranceCategory.rawValue) vs taste dominan \(evaluation.tasteCategory.rawValue): tidak wajib sama; volatile (kering) vs slurp bisa beda tajam/landai.")
        }
        if primaryCategory == evaluation.tasteCategory {
            parts.append("Pilihan L1 final (\(primaryCategory.rawValue)) selaras dengan kategori taste yang kamu isi.")
        } else {
            parts.append("L1 pilihan akhir: \(primaryCategory.rawValue) (eksplorasi), taste card: \(evaluation.tasteCategory.rawValue)—keduanya boleh beda: L1 = kesan total, card = dominan sesaat.")
        }
        return parts.joined(separator: "\n\n")
    }

    var spotlightMessage: String {
        let base = "Terekam di sesi: asam \(Int(evaluation.acidity)), manis \(Int(evaluation.sweetness)), pahit \(Int(evaluation.bitterness)), body \(Int(evaluation.bodyScore))."
        if let secondaryNote, let specificNote {
            return "\(base) Kamu mempersempit rasa dari \(primaryCategory.rawValue) ke \(secondaryNote), lalu sampai ke \(specificNote). Detail pilihan ini sudah tersimpan di riwayat."
        }
        if let secondaryNote {
            return "\(base) Turunan: \(secondaryNote) di bawah payung \(primaryCategory.rawValue)."
        }
        return "\(base) Pilihan utama: \(primaryCategory.rawValue)."
    }

    var brewGuidance: String {
        BrewHeuristics.nextBrewGuidance(for: evaluation)
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
