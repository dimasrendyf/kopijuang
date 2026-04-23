//
//  CascadingQuizViewModel.swift
//  KopiJuang
//

import Foundation
import Observation
import SwiftData

@MainActor
@Observable
final class CascadingQuizViewModel {
    let evaluation: SensoryEvaluation
    let selectedPrimaryCategory: FlavorCategory
    let parentNodeId: String

    var parentNode: FlavorWheelNode?
    var selectedNode: FlavorWheelNode?
    var navigateToNext = false
    var navigateToFinalAnalysis = false

    init(
        evaluation: SensoryEvaluation,
        selectedPrimaryCategory: FlavorCategory,
        parentNodeId: String
    ) {
        self.evaluation = evaluation
        self.selectedPrimaryCategory = selectedPrimaryCategory
        self.parentNodeId = parentNodeId
        self.parentNode = FlavorWheelNode.findNode(by: parentNodeId)
    }

    func transitionPrompt(for parent: FlavorWheelNode) -> String {
        if parent.layer == 1 {
            return "\(parent.name) itu luas. Turunan rasa mana yang paling mendekati rasa kopimu?"
        }
        return "Bagus. Sekarang pilih note paling spesifik yang paling terasa dari \(parent.name)."
    }

    var primaryActionTitle: String {
        guard
            let parent = parentNode,
            let id = selectedNode?.id,
            let selected = parent.children.first(where: { $0.id == id })
        else { return "Lanjut" }
        return selected.children.isEmpty ? "Selesai & Lihat Analisis Final" : "Lanjut ke Layer Berikutnya"
    }

    func selectChild(_ child: FlavorWheelNode) {
        selectedNode = child
    }

    func continueExploration(modelContext: ModelContext, userProgresses: [UserProgress]) {
        guard let node = selectedNode else { return }
        saveExploration(for: node, modelContext: modelContext, userProgresses: userProgresses)
        if node.children.isEmpty {
            saveSession(completed: true, modelContext: modelContext, userProgresses: userProgresses)
            navigateToFinalAnalysis = true
        } else {
            navigateToNext = true
        }
    }

    private func saveExploration(
        for child: FlavorWheelNode,
        modelContext: ModelContext,
        userProgresses: [UserProgress]
    ) {
        let progress = UserProgressStore.primary(from: userProgresses, in: modelContext)
        if child.layer == 2, !progress.unlockedSecondaryNotes.contains(child.name) {
            progress.unlockedSecondaryNotes.append(child.name)
        } else if child.layer == 3, !progress.unlockedSpecificNotes.contains(child.name) {
            progress.unlockedSpecificNotes.append(child.name)
        }
        progress.appendExperiencedNote(child.name)
        do {
            try modelContext.save()
        } catch {
            print("Failed saving Cascading guess: \(error.localizedDescription)")
        }
    }

    private func saveSession(
        completed: Bool,
        modelContext: ModelContext,
        userProgresses: [UserProgress]
    ) {
        guard completed else { return }
        let progress = UserProgressStore.primary(from: userProgresses, in: modelContext)
        let history = SessionHistory(
            beanName: evaluation.beanName,
            roastLevel: evaluation.roastLevel,
            processLevel: evaluation.processLevel,
            finalCategory: selectedPrimaryCategory.rawValue
        )
        modelContext.insert(history)
        progress.completedSessions.append(history)
        do {
            try modelContext.save()
        } catch {
            print("Failed saving session history: \(error.localizedDescription)")
        }
    }
}
