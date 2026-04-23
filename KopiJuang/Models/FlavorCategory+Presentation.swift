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
        case .sweet: "Manis alami seperti gula tebu, karamel, madu, hingga vanila."
        case .floral: "Karakter bunga, teh, dan nuansa floral yang halus."
        case .fruity: "Segar dan cerah dengan aksen buah sitrun maupun tropis."
        case .sourFermented: "Kompleksitas asam, fermentasi, winey, hingga nuansa alkoholik."
        case .greenVegetative: "Karakter hijau, herbal, zaitun, dan kacang mentah."
        case .other: "Catatan anomali: kertas, tanah, atau kesan kimiawi (objektif)."
        case .roasted: "Profil sangrai, sereal, asap, hingga tembakau."
        case .spices: "Rempah kering seperti cengkih, pala, kayu manis, dan lada."
        case .nuttyCocoa: "Gurih kacang-kacangan, biji-bijian, serta intensitas kakao atau cokelat."
        }
    }
}
