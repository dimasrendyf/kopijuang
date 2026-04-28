//
//  SessionSnapshot.swift
//  Ringkasan sesi pengecapan untuk riwayat & analisis.
//

import Foundation

/// Snapshot ringkas yang dipersist untuk riwayat; nilai rasa 0...10.
struct SessionSnapshot: Equatable, Sendable {
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

extension SessionSnapshot: Codable {
    nonisolated init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        beanName = try c.decode(String.self, forKey: .beanName)
        beanOrigin = try c.decode(String.self, forKey: .beanOrigin)
        roastLevel = try c.decode(String.self, forKey: .roastLevel)
        processLevel = try c.decode(String.self, forKey: .processLevel)
        fragranceIntensity = try c.decode(Double.self, forKey: .fragranceIntensity)
        fragranceCategory = try c.decode(String.self, forKey: .fragranceCategory)
        aromaContrast = try c.decode(String.self, forKey: .aromaContrast)
        aromaIntensity = try c.decode(Double.self, forKey: .aromaIntensity)
        aromaCategory = try c.decode(String.self, forKey: .aromaCategory)
        acidity = try c.decode(Double.self, forKey: .acidity)
        sweetness = try c.decode(Double.self, forKey: .sweetness)
        bitterness = try c.decode(Double.self, forKey: .bitterness)
        bodyScore = try c.decode(Double.self, forKey: .bodyScore)
        tasteCategory = try c.decode(String.self, forKey: .tasteCategory)
        primaryCategory = try c.decode(String.self, forKey: .primaryCategory)
        secondaryNote = try c.decodeIfPresent(String.self, forKey: .secondaryNote)
        specificNote = try c.decodeIfPresent(String.self, forKey: .specificNote)
    }

    nonisolated func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encode(beanName, forKey: .beanName)
        try c.encode(beanOrigin, forKey: .beanOrigin)
        try c.encode(roastLevel, forKey: .roastLevel)
        try c.encode(processLevel, forKey: .processLevel)
        try c.encode(fragranceIntensity, forKey: .fragranceIntensity)
        try c.encode(fragranceCategory, forKey: .fragranceCategory)
        try c.encode(aromaContrast, forKey: .aromaContrast)
        try c.encode(aromaIntensity, forKey: .aromaIntensity)
        try c.encode(aromaCategory, forKey: .aromaCategory)
        try c.encode(acidity, forKey: .acidity)
        try c.encode(sweetness, forKey: .sweetness)
        try c.encode(bitterness, forKey: .bitterness)
        try c.encode(bodyScore, forKey: .bodyScore)
        try c.encode(tasteCategory, forKey: .tasteCategory)
        try c.encode(primaryCategory, forKey: .primaryCategory)
        try c.encodeIfPresent(secondaryNote, forKey: .secondaryNote)
        try c.encodeIfPresent(specificNote, forKey: .specificNote)
    }

    private enum CodingKeys: String, CodingKey {
        case beanName, beanOrigin, roastLevel, processLevel
        case fragranceIntensity, fragranceCategory, aromaContrast, aromaIntensity, aromaCategory
        case acidity, sweetness, bitterness, bodyScore, tasteCategory
        case primaryCategory, secondaryNote, specificNote
    }
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
