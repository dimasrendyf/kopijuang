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
        case .fragrance: "Kenali saat biji kering — sebelum air mengubah profil"
        case .aroma:     "Lacak saat bloom — uap angkat senyawa berbeda"
        case .taste:     "Rasakan via seruput & retronasal di mulut"
        }
    }

    /// Deskripsi spesifik per kategori untuk baris panduan di daftar.
    func learningLine(for category: FlavorCategory) -> String {
        switch (self, category) {
        // MARK: Fragrance
        case (.fragrance, .sweet):           "Kenali sweet saat biji kering — karamel, gula aren, madu, toffee"
        case (.fragrance, .floral):          "Cari floral saat biji kering — melati, mawar, lavender, pollen"
        case (.fragrance, .fruity):          "Identifikasi fruity saat biji kering — sitrus, beri, stone fruit"
        case (.fragrance, .sourFermented):   "Bedakan sour/fermented saat kering — winey, asam cerah vs cuka"
        case (.fragrance, .greenVegetative): "Deteksi vegetal saat biji kering — rumput, polong, herba mentah"
        case (.fragrance, .other):           "Catat anomali saat biji kering — kertas, tanah, kimiawi"
        case (.fragrance, .roasted):         "Kenali roasted saat biji kering — sereal, malt, roti panggang"
        case (.fragrance, .spices):          "Identifikasi spices saat biji kering — lada, cengkih, pala"
        case (.fragrance, .nuttyCocoa):      "Cari nutty/cocoa saat biji kering — kacang panggang, kakao"
        // MARK: Aroma
        case (.aroma, .sweet):              "Lacak sweet saat bloom — brown sugar, vanila, santan ringan"
        case (.aroma, .floral):             "Deteksi floral saat bloom — teh, pollen, bunga segar"
        case (.aroma, .fruity):             "Cari fruity saat bloom — sitrus lembut, jeruk, tropis"
        case (.aroma, .sourFermented):      "Evaluasi sour saat bloom — anggur, asam buah, cuka samar"
        case (.aroma, .greenVegetative):    "Amati vegetal saat bloom — buncis, herba, rumput basah"
        case (.aroma, .other):              "Identifikasi anomali saat bloom — apek, tanah, kimiawi samar"
        case (.aroma, .roasted):            "Lacak roasted saat bloom — malt, cokelat sangrai, roti"
        case (.aroma, .spices):             "Cari spices saat bloom — rempah basah, cengkih, pala"
        case (.aroma, .nuttyCocoa):         "Deteksi nutty/cocoa saat bloom — hazelnut, cokelat, almond"
        // MARK: Taste
        case (.taste, .sweet):              "Rasakan sweet via seruput — body tengah, gula aren, finish manis"
        case (.taste, .floral):             "Deteksi floral via retronasal — melati, teh, nuansa halus"
        case (.taste, .fruity):             "Rasakan fruity via seruput — depan sitrus, tengah beri"
        case (.taste, .sourFermented):      "Evaluasi sour via sisi lidah — asam alami vs asetat tajam"
        case (.taste, .greenVegetative):    "Catat vegetal di aftertaste — polong, herba, sepat"
        case (.taste, .other):              "Identifikasi anomali via retronasal — kertas, tanah, posisi"
        case (.taste, .roasted):            "Bedakan roasted via seruput — malt vs pahit sangrai kasar"
        case (.taste, .spices):             "Rasakan spices via retronasal — cengkih tengah, lada belakang"
        case (.taste, .nuttyCocoa):         "Cari nutty/cocoa via seruput — lemak tengah, pahit cokelat"
        }
    }
}
