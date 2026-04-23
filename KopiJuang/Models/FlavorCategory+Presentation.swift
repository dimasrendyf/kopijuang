//
//  FlavorCategory+Presentation.swift
//  KopiJuang
//

import SwiftUI

extension FlavorCategory {
    var categoryAccentColor: Color {
        switch self {
        case .floral: .teal
        case .fruity: .orange
        case .nutty: .brown
        case .sweet: .pink
        }
    }

    var categoryIconName: String {
        switch self {
        case .fruity: "leaf.fill"
        case .floral: "sparkles"
        case .nutty: "circle.grid.3x3.fill"
        case .sweet: "cube.fill"
        }
    }

    var categoryBlurb: String {
        switch self {
        case .floral: "Nuansa bunga/teh lewat aroma retronasal."
        case .fruity: "Karakter buah yang fresh dan cerah."
        case .nutty: "Kacang/cokelat hangat yang membumi."
        case .sweet: "Manis alami yang bikin cup terasa round."
        }
    }
}
