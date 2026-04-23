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
        let e = BrewHeuristics.expectation(roast: evaluation.roastLevel, process: evaluation.processLevel)
        return "Kisaran tipikal untuk \(evaluation.roastLevel) + \(evaluation.processLevel): asam \(e.acidity), manis \(e.sweetness), pahit \(e.bitterness), body \(e.body) (1–10, perkiraan saja)."
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
