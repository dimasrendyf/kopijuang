//
//  SessionSnapshot.swift
//  Ringkasan sesi pengecapan untuk riwayat & analisis.
//

import Foundation

/// Snapshot ringkas yang dipersist untuk riwayat; nilai rasa 1...10.
struct SessionSnapshot: Codable, Equatable, Sendable {
    var beanName: String
    var beanOrigin: String
    var roastLevel: String
    var processLevel: String

    var fragranceIntensity: Double
    var fragranceCategory: String
    var aromaContrast: String
    var aromaIntensity: Double
    var aromaCategory: String

    var acidity: Double
    var sweetness: Double
    var bitterness: Double
    var bodyScore: Double
    var tasteCategory: String

    var primaryCategory: String
    var secondaryNote: String?
    var specificNote: String?
}

extension SessionSnapshot {
    init(
        evaluation: SensoryEvaluation,
        primaryCategory: FlavorCategory,
        selectedNode: FlavorWheelNode?
    ) {
        self.beanName = evaluation.beanName
        self.beanOrigin = evaluation.beanOrigin
        self.roastLevel = evaluation.roastLevel
        self.processLevel = evaluation.processLevel
        self.fragranceIntensity = evaluation.fragranceIntensity
        self.fragranceCategory = evaluation.fragranceCategory.rawValue
        self.aromaContrast = evaluation.aromaContrast.rawValue
        self.aromaIntensity = evaluation.aromaIntensity
        self.aromaCategory = evaluation.aromaCategory.rawValue
        self.acidity = evaluation.acidity
        self.sweetness = evaluation.sweetness
        self.bitterness = evaluation.bitterness
        self.bodyScore = evaluation.bodyScore
        self.tasteCategory = evaluation.tasteCategory.rawValue
        self.primaryCategory = primaryCategory.rawValue
        (self.secondaryNote, self.specificNote) = Self.wheelLabels(from: selectedNode)
    }

    private static func wheelLabels(from node: FlavorWheelNode?) -> (String?, String?) {
        guard let node else { return (nil, nil) }
        if node.layer == 2 {
            return (node.name, nil)
        }
        if node.layer == 3, let parentId = node.parent, let p = FlavorWheelNode.findNode(by: parentId) {
            return (p.name, node.name)
        }
        if node.layer == 3 {
            return (nil, node.name)
        }
        return (nil, nil)
    }

    func toSensoryEvaluation() -> SensoryEvaluation {
        SensoryEvaluation(
            beanName: beanName,
            beanOrigin: beanOrigin,
            roastLevel: roastLevel,
            processLevel: processLevel,
            fragranceIntensity: fragranceIntensity,
            fragranceCategory: FlavorCategory(rawValue: fragranceCategory) ?? .fruity,
            aromaContrast: AromaContrast(rawValue: aromaContrast) ?? .unsure,
            aromaIntensity: aromaIntensity,
            aromaCategory: FlavorCategory(rawValue: aromaCategory) ?? .fruity,
            acidity: acidity,
            sweetness: sweetness,
            bitterness: bitterness,
            bodyScore: bodyScore,
            tasteCategory: FlavorCategory(rawValue: tasteCategory) ?? .fruity
        )
    }
}

extension SessionHistory {
    var decodedSnapshot: SessionSnapshot? {
        guard let snapshotData, !snapshotData.isEmpty else { return nil }
        return try? JSONDecoder().decode(SessionSnapshot.self, from: snapshotData)
    }
}
