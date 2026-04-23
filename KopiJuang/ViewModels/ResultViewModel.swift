//
//  ResultViewModel.swift
//  KopiJuang
//

import Foundation
import Observation
import SwiftData

@MainActor
@Observable
final class ResultViewModel {
    let evaluation: SensoryEvaluation

    var showingFeedback = false
    var isCorrect = true
    var feedbackMessage = ""
    var selectedCategory: FlavorCategory?
    var showDiscovery = false
    var navigateToCascading = false

    init(evaluation: SensoryEvaluation) {
        self.evaluation = evaluation
    }

    var brewTipInsight: String {
        let roast = evaluation.roastLevel.lowercased()
        let process = evaluation.processLevel.lowercased()
        if evaluation.bitterness >= 8 && roast == "dark" {
            return "Pahit dominan kemungkinan dari profil roast + ekstraksi."
        }
        if evaluation.acidity >= 8 && roast == "light" {
            return "Keasaman terasa cukup agresif untuk profil light roast."
        }
        if evaluation.sweetness <= 4 && (process == "natural" || process == "honey") {
            return "Manis alami dari process belum keluar maksimal."
        }
        if evaluation.bodyScore <= 4 {
            return "Body terasa tipis, kemungkinan ekstraksi masih kurang."
        }
        return "Cup kamu sudah cukup seimbang untuk parameter saat ini."
    }

    var brewTipAction: String {
        let roast = evaluation.roastLevel.lowercased()
        let process = evaluation.processLevel.lowercased()
        if evaluation.bitterness >= 8 && roast == "dark" {
            return "Coba turunkan suhu ke 88-90C atau percepat waktu seduh."
        }
        if evaluation.acidity >= 8 && roast == "light" {
            return "Coba gilingan sedikit lebih halus agar ekstraksi lebih seimbang."
        }
        if evaluation.sweetness <= 4 && (process == "natural" || process == "honey") {
            return "Coba rasio sedikit lebih pekat atau naikkan suhu 1-2C."
        }
        if evaluation.bodyScore <= 4 {
            return "Coba grind sedikit lebih halus atau tambah waktu kontak 10-15 detik."
        }
        return "Pertahankan resep ini lalu ubah 1 variabel kecil saja di sesi berikutnya."
    }

    func checkAnswer(
        _ category: FlavorCategory,
        modelContext: ModelContext,
        userProgresses: [UserProgress]
    ) {
        selectedCategory = category
        isCorrect = true
        feedbackMessage = "\(category.rawValue) itu luas. Yuk lanjut, rasa turunan apa yang paling mendekati kopimu?"

        let progress = UserProgressStore.primary(from: userProgresses, in: modelContext)
        if !progress.unlockedPrimaryNotes.contains(category.rawValue) {
            progress.unlockedPrimaryNotes.append(category.rawValue)
        }
        progress.appendExperiencedNote(category.rawValue)
        do {
            try modelContext.save()
        } catch {
            print("Failed saving ResultView progress: \(error.localizedDescription)")
        }
        showingFeedback = true
    }

    func onFeedbackNextTapped() {
        showingFeedback = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.navigateToCascading = true
        }
    }
}
