//
//  FlavorCategory.swift
//  KopiJuang
//
//  Selaras kelompok luar umum peta cita rasa (SCA Taster’s / WCR lexicon):
//  Sweet, Floral, Fruity, Sour / Fermented, Green / Vegetative, Other, Roasted, Spices, Nutty / Cocoa
//

import Foundation

enum FlavorCategory: String, CaseIterable, Identifiable, Sendable {
    case sweet = "Sweet"
    case floral = "Floral"
    case fruity = "Fruity"
    case sourFermented = "Sour / Fermented"
    case greenVegetative = "Green / Vegetative"
    case other = "Other"
    case roasted = "Roasted"
    case spices = "Spices"
    case nuttyCocoa = "Nutty / Cocoa"

    var id: String { rawValue }
}

// MARK: - Legacy stored strings
extension FlavorCategory {
    /// Normalisasi isi lama (4 kategori) ke label L1 saat ini.
    static func fromStoredName(_ s: String) -> FlavorCategory? {
        let t = s.trimmingCharacters(in: .whitespacesAndNewlines)
        if let c = FlavorCategory(rawValue: t) { return c }
        switch t {
        case "Nutty": return .nuttyCocoa
        default: return nil
        }
    }
}

extension String {
    /// UNTUK tampil / kunci: map "Nutty" lama ke "Nutty / Cocoa".
    var asNormalizedPrimaryFlavor: String {
        if self == "Nutty" { return FlavorCategory.nuttyCocoa.rawValue }
        return self
    }
}
