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

    var learningPrefix: String { learningLine }

    /// Baris bantu (ID) di daftar belajar, digabung dengan nama kategori.
    var learningLine: String {
        switch self {
        case .fragrance:
            "Latihan cium (dry) untuk jenis rasa"
        case .aroma:
            "Latihan cium (wet/bloom) untuk jenis rasa"
        case .taste:
            "Latihan retronasal & lidah (sip) untuk jenis rasa"
        }
    }
}
