//
//  AtlasViewModel.swift
//  KopiJuang
//

import Foundation
import Observation

@MainActor
@Observable
final class AtlasViewModel {
    var searchText = ""

    /// Builds flat `FlavorNote` list from progress + static wheel.
    func flavorNotes(from userProgresses: [UserProgress]) -> [FlavorNote] {
        let unlockedPrimary = Set(
            userProgresses
                .flatMap(\.unlockedPrimaryNotes)
                .map { $0.asNormalizedPrimaryFlavor }
        )
        let unlockedSecondary = Set(userProgresses.flatMap(\.unlockedSecondaryNotes))
        let unlockedSpecific = Set(userProgresses.flatMap(\.unlockedSpecificNotes))
        let experienced = userProgresses.flatMap(\.allExperiencedNotes)
        var list: [FlavorNote] = []

        func traverse(_ node: FlavorWheelNode) {
            let isUnlocked: Bool
            if node.layer == 1 {
                isUnlocked = unlockedPrimary.contains(node.name)
            } else if node.layer == 2 {
                isUnlocked = unlockedSecondary.contains(node.name)
            } else {
                isUnlocked = unlockedSpecific.contains(node.name)
            }
            let experienceCount = experienced.filter { $0 == node.name }.count
            list.append(FlavorNote(
                name: node.name,
                category: node.layer == 1 ? node.name : (node.parent ?? ""),
                description: node.description,
                icon: node.layer == 1 ? "star.fill" : "circle.fill",
                isUnlocked: isUnlocked,
                experienceCount: experienceCount,
                familiarityLevel: familiarityLabel(for: experienceCount)
            ))
            node.children.forEach { traverse($0) }
        }

        FlavorWheelData.wheel.forEach { traverse($0) }
        return list
    }

    private func familiarityLabel(for count: Int) -> String {
        switch count {
        case 0: "Belum dijelajahi"
        case 1...2: "Pemula"
        case 3...5: "Kenal"
        case 6...9: "Akrab"
        default: "Peka"
        }
    }

    func filteredFlavors(from userProgresses: [UserProgress]) -> [FlavorNote] {
        let flavors = flavorNotes(from: userProgresses)
        if searchText.isEmpty { return flavors }
        return flavors.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
}
