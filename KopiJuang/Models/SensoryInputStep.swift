//
//  SensoryInputStep.swift
//  KopiJuang
//

import Foundation

enum SensoryInputStep: Int, CaseIterable, Hashable, Sendable {
    case fragrance = 0
    case aroma = 1
    case taste = 2

    var title: String {
        switch self {
        case .fragrance: "Fragrance"
        case .aroma: "Aroma"
        case .taste: "Taste"
        }
    }

    var subtitle: String {
        switch self {
        case .fragrance:
            "Tahap 1: cium wangi kopi saat masih kering (belum dicampur air)."
        case .aroma:
            "Tahap 2: cium wangi kopi setelah kena air panas saat blooming."
        case .taste:
            "Tahap 3: nilai rasa saat diseruput (taste + retronasal)."
        }
    }
}
