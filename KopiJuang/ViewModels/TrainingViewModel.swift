//
//  TrainingViewModel.swift
//  KopiJuang
//

import Foundation
import Observation

@MainActor
@Observable
final class TrainingViewModel {
    let category: FlavorCategory
    let stage: DiscoveryStage
    private let block: TrainingContentBlock

    init(category: FlavorCategory, stage: DiscoveryStage) {
        self.category = category
        self.stage = stage
        self.block = TrainingContent.block(category: category, stage: stage)
    }

    var stageSubtitle: String { block.stageIntro }

    var trainingPrompt: String { block.lead }

    var stageSteps: [String] { block.steps }

    var referenceNote: String { block.reference }

    /// Label bantu bila nanti aset/referensi visual (nama singkat, ID).
    func imageLabel(for flavorName: String) -> String {
        if let c = FlavorCategory.fromStoredName(flavorName) { return c.rawValue }
        if let c = FlavorCategory(rawValue: flavorName) { return c.rawValue }
        let key = flavorName.lowercased()
        switch key {
        case "fruity": return "jeruk, berry, tropis"
        case "floral": return "bunga, teh floral"
        case "nutty", "nutty / cocoa", "nuttycocoa": return "kacang, kakao, cokelat"
        case "sweet": return "madu, karamel, vanila"
        case "sour", "sour / fermented", "sourfermented": return "asam, winey, ferment"
        case "green", "green / vegetative", "greenvegetative": return "hijau, herb, zaitun"
        case "other": return "kertas, bumi, asing"
        case "roasted": return "malt, sangrai, asap ringan"
        case "spices": return "cengkih, pala, lada"
        default: return "referensi"
        }
    }
}
