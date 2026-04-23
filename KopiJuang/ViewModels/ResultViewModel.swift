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
        BrewHeuristics.softTypicalLine(roast: evaluation.roastLevel, process: evaluation.processLevel)
    }

    var brewTipAction: String {
        BrewHeuristics.nextBrewGuidance(for: evaluation)
    }

    func checkAnswer(
        _ category: FlavorCategory,
        modelContext: ModelContext,
        userProgresses: [UserProgress]
    ) {
        selectedCategory = category
        isCorrect = true
        feedbackMessage = "Kelompok \(category.rawValue) luas banget. Lanjut, pilih rasa turunan yang paling dekat—biar jurnal rasa kamu makin jelas, bukan cuma kategori besarnya saja."

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
