//
//  DiscoveryStage.swift
//  KopiJuang
//

import Foundation

enum DiscoveryStage: String, CaseIterable, Identifiable {
    case fragrance
    case aroma
    case taste

    var id: String { rawValue }

    var title: String {
        switch self {
        case .fragrance: return "Fragrance"
        case .aroma: return "Aroma"
        case .taste: return "Taste"
        }
    }

    var learningPrefix: String {
        switch self {
        case .fragrance:
            return "How to smell"
        case .aroma:
            return "How to identify aroma"
        case .taste:
            return "How to taste"
        }
    }
}
