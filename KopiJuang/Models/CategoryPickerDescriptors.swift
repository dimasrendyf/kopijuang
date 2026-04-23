//
//  CategoryPickerDescriptors.swift
//  KopiJuang
//  Teks bantu per tahap pengecap, selaras cangkang cita rasa (daring).
//

import Foundation

struct FlavorCategoryDescriptor: Sendable {
    let summary: String
    let examples: [String]
}

enum CategoryPickerDescriptors {
    static func descriptor(for category: FlavorCategory, stage: DiscoveryStage) -> FlavorCategoryDescriptor {
        switch stage {
        case .fragrance: dry(category)
        case .aroma: wet(category)
        case .taste: sip(category)
        }
    }

    private static func dry(_ c: FlavorCategory) -> FlavorCategoryDescriptor {
        switch c {
        case .sweet: FlavorCategoryDescriptor(
            summary: "Di bubuk kering, cari kesan gula, madu, karamel, vanila (aroma, bukan rasa penuh).",
            examples: ["Caramel (dry)", "Vanilla (dry)", "Maple (dry)"]
        )
        case .floral: FlavorCategoryDescriptor(
            summary: "Sebelum air: kelopak, melati, mawar, serbuk sari tipis; hindari sisa sabun/parfum.",
            examples: ["Jasmine (dry)", "Black tea (dry)"]
        )
        case .fruity: FlavorCategoryDescriptor(
            summary: "Bubuk kering: manis buah, sitrus, berry, tropis, sering tajam/tersengat (volatile).",
            examples: ["Lemon (dry)", "Strawberry (dry)"]
        )
        case .sourFermented: FlavorCategoryDescriptor(
            summary: "Asam volatile ringan, buah terfermentasi kering, winey (sempit), bukan cuka kuat dulu.",
            examples: ["Acetic (ringan, dry)", "Winey (kering)"]
        )
        case .greenVegetative: FlavorCategoryDescriptor(
            summary: "Bau hijau, polong, rumput, zaitun muda, ‘green bean’/underdeveloped bila muncul.",
            examples: ["Pea/Edamame (dry)", "Olive (dry)"]
        )
        case .other: FlavorCategoryDescriptor(
            summary: "Bau asing/ambang: kertas, bumi, pelarut ringan—catat level, jangan dulu menilai sumber pasti.",
            examples: ["Cardboard (dry)", "Damp musty (dry)"]
        )
        case .roasted: FlavorCategoryDescriptor(
            summary: "Sangrai kering: malt, sereal, biji/kulit, asap sangat ringan sebelum cairan.",
            examples: ["Malt (dry)", "Ash (kering)"]
        )
        case .spices: FlavorCategoryDescriptor(
            summary: "Bumbu kering/serbuk: kayu manis, cengkih, lada, pekak—sering tajam tapi renda.",
            examples: ["Cinnamon (dry)", "Black pepper (dry)"]
        )
        case .nuttyCocoa: FlavorCategoryDescriptor(
            summary: "Bubuk kering: biji, almond, kacang, bubuk cokelat, tanpa cairan belum cukup.",
            examples: ["Cocoa (dry)", "Almond (dry)"]
        )
        }
    }

    private static func wet(_ c: FlavorCategory) -> FlavorCategoryDescriptor {
        switch c {
        case .sweet: FlavorCategoryDescriptor(
            summary: "Wet: manis penguapan naik, madu, karamel, vanila, sering membulat saat suhu turun.",
            examples: ["Honey (wet)", "Caramel (wet)"]
        )
        case .floral: FlavorCategoryDescriptor(
            summary: "Bloom: aroma bunga ‘naik’; bandingkan dengan kering, catat penguatan/penyempitan.",
            examples: ["Jasmine (wet)", "Rose (wet)"]
        )
        case .fruity: FlavorCategoryDescriptor(
            summary: "Setelah air: sitrus, berry, tropis; sering muncul lebih jelas/berpindah vs dry.",
            examples: ["Citrus (wet)", "Berry (wet)"]
        )
        case .sourFermented: FlavorCategoryDescriptor(
            summary: "Wet: asam, ferment, winey, alkohol lembut; cek bila kontras ke dry tajam/landai.",
            examples: ["Winey (wet)", "Fermented fruit (wet)"]
        )
        case .greenVegetative: FlavorCategoryDescriptor(
            summary: "Air panas: hijau, herb, zaitun, ‘snap pea’; banding fase kering ke basah.",
            examples: ["Grass (wet)", "Olive (wet)"]
        )
        case .other: FlavorCategoryDescriptor(
            summary: "Basah: lembab, kertas tua, bumi, kimia penguapan—catat tanpa menebak proses sumber.",
            examples: ["Wet paper", "Damp (wet)"]
        )
        case .roasted: FlavorCategoryDescriptor(
            summary: "Roast/maillard: sereal, malt, aspal, asap ringan, panas bukan gosong kasar dulu.",
            examples: ["Malt (wet)", "Smoke (ringan)"]
        )
        case .spices: FlavorCategoryDescriptor(
            summary: "Uap: rempah basah, lada, cengkih, cengkih-kulit, beda lebar dengan dry.",
            examples: ["Clove (wet)", "Black pepper (wet)"]
        )
        case .nuttyCocoa: FlavorCategoryDescriptor(
            summary: "Cair: kacang, kakao, cokelat, almond—sering tengah panjang, bukan tengah lidah aja.",
            examples: ["Cocoa (wet)", "Hazelnut (wet)"]
        )
        }
    }

    private static func sip(_ c: FlavorCategory) -> FlavorCategoryDescriptor {
        switch c {
        case .sweet: FlavorCategoryDescriptor(
            summary: "Di mulut, manis = bulat, finish manis, sering pasca-asam, bukan gula tabel—slurp + retronasal.",
            examples: ["Roundness", "Sweetness balance"]
        )
        case .floral: FlavorCategoryDescriptor(
            summary: "Sip+retronasal: ‘bunga’ muncul di hidung belakang; retronasal dominan, bukan manis sisa saja.",
            examples: ["Elderflower (aftertaste)"]
        )
        case .fruity: FlavorCategoryDescriptor(
            summary: "Lidah: sitrus, berry, buah, sering sejalan acidity/brightness; cek sisi depan tengah-belakang.",
            examples: ["Citrus retronasal", "Tropical retronasal"]
        )
        case .sourFermented: FlavorCategoryDescriptor(
            summary: "Asam/ferment: struktur, ‘winey’ panjang, alkohol kecil, tidak menyengat tenggorokan.",
            examples: ["Malic/citric (sip)"]
        )
        case .greenVegetative: FlavorCategoryDescriptor(
            summary: "Sip: hijau, polong, zaitun, retronasal herba, beda bila suhu 50–60°C vs panas.",
            examples: ["Olive retronasal", "Grassy (sip)"]
        )
        case .other: FlavorCategoryDescriptor(
            summary: "Retronasal asing, kertas, bumi, kimia; ukur seberapa mengganggu vs netral, catat aja dulu.",
            examples: ["Papery aftertaste"]
        )
        case .roasted: FlavorCategoryDescriptor(
            summary: "Cita panggang: malt, sereal, asap, tahan panjang, beda pahit vs roast defect.",
            examples: ["Roast (sip)", "Ash (very light)"]
        )
        case .spices: FlavorCategoryDescriptor(
            summary: "Lidah belakang: lada, cengkih, pala, tajam tapi rapi, bukan cuma retronasal doang.",
            examples: ["Pepper finish", "Clove mid-palate"]
        )
        case .nuttyCocoa: FlavorCategoryDescriptor(
            summary: "Kacang, kakao, cokelat, almond—mid/after; beda pahit cokelat vs pahit buah/alkali.",
            examples: ["Dark chocolate (after)", "Almond (mid)"]
        )
        }
    }
}

extension FlavorCategory {
    var pickerGridIconName: String {
        switch self {
        case .fruity: "leaf.fill"
        case .floral: "sparkles"
        case .nuttyCocoa: "circle.grid.3x3.fill"
        case .sweet: "heart.fill"
        case .sourFermented: "drop.fill"
        case .greenVegetative: "leaf"
        case .other: "ellipsis.circle"
        case .roasted: "flame"
        case .spices: "circle.grid.2x2"
        }
    }
}
