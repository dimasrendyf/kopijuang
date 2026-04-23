//
//  FlavorCategory+Presentation.swift
//  KopiJuang
//

import SwiftUI

extension FlavorCategory {
    var categoryAccentColor: Color {
        switch self {
        case .sweet: .pink
        case .floral: .teal
        case .fruity: .orange
        case .sourFermented: .purple
        case .greenVegetative: .green
        case .other: .gray
        case .roasted: .indigo
        case .spices: .red
        case .nuttyCocoa: .brown
        }
    }

    var categoryIconName: String {
        switch self {
        case .sweet: "cube.transparent.fill"
        case .floral: "sparkles"
        case .fruity: "leaf.fill"
        case .sourFermented: "drop.triangle.fill"
        case .greenVegetative: "leaf.arrow.circlepath"
        case .other: "questionmark.diamond"
        case .roasted: "flame.fill"
        case .spices: "wind"
        case .nuttyCocoa: "circle.grid.3x3.fill"
        }
    }

    var categoryBlurb: String {
        switch self {
        case .sweet: "Manis alami, karamel, madu, vanila (tanpa gula tambahan)."
        case .floral: "Bunga, teh floral, aromatik halus retronasal."
        case .fruity: "Sitrun, buah, tropis, terang di lidah/ aroma."
        case .sourFermented: "Asam terukur, fermentasi, winey, alkohol lembut."
        case .greenVegetative: "Hijau, herbal, zaitun, kacang mentah, vegetal."
        case .other: "Asing ringan: kertas, bumi, lembab, kimia ringan (dokumentasi, bukan cap buruk)."
        case .roasted: "Panggang, sereal, aspal, tembakau, sangrai."
        case .spices: "Cengkih, pala, kayu manis, lada, rempah kering."
        case .nuttyCocoa: "Kacang, biji, kakao, cokelat, almond."
        }
    }
}
