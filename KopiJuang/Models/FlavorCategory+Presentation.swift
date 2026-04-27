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
        case .sweet:
            "Manis bersih & ronde — gula tebu, karamel, brown sugar, madu, molasses, toffee, vanila. Evaluasi intensitas & panjang finish."
        case .floral:
            "Nuansa bunga & teh aromatik — melati, mawar, lavender, chamomile, bergamot. Biasa pada washed Arabica; terdeteksi via retronasal."
        case .fruity:
            "Cerah & segar — sitrus (jeruk, lemon, grapefruit), beri (ceri, blueberry), stone fruit, kismis, tropis (mangga, lychee). (SCA)"
        case .sourFermented:
            "Kecerahan asam & fermentasi — winey, cuka apel, buah over-ripe, kombucha. Bedakan asam alami (cerah) vs asetat (menusuk)."
        case .greenVegetative:
            "Hijau mentah & herba — rumput segar, polong, zaitun, dill, sage. Wajar dalam jumlah kecil; intens = potensi under-developed."
        case .other:
            "Taint & catatan anomali — kertas, tanah, karet, phenolic, kimiawi. Identifikasi posisi & intensitas sebelum menyimpulkan defek."
        case .roasted:
            "Reaksi Maillard & sangrai — sereal, malt, roti panggang, dark cocoa, asap, tembakau, arang. Umum pada medium-dark roast."
        case .spices:
            "Rempah aromatik kering — lada hitam, cengkih, pala, kayu manis, kapulaga, anise. Sering muncul pada natural process & dark roast."
        case .nuttyCocoa:
            "Lemak biji & kakao — hazelnut, almond, walnut, cocoa nib, dark chocolate, peanut butter. Umum pada medium roast washed bean."
        }
    }
}
