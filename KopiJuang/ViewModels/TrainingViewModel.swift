//
//  TrainingViewModel.swift
//  KopiJuang
//

import Foundation
import Observation

@MainActor
@Observable
final class TrainingViewModel {
    let flavor: String
    let stage: DiscoveryStage

    init(flavor: String, stage: DiscoveryStage) {
        self.flavor = flavor
        self.stage = stage
    }

    var stageSubtitle: String {
        switch stage {
        case .fragrance:
            "Gapapa kalau masih bingung. Yuk latih hidungmu dulu di tahap fragrance."
        case .aroma:
            "Wajar kalau dry dan wet kadang mirip. Yuk latih pembacaan aroma bloom."
        case .taste:
            "Gapapa salah tebak, ini proses belajar rasa di lidah."
        }
    }

    var trainingPrompt: String {
        switch stage {
        case .fragrance:
            "Siapkan referensi \(flavor) lalu cium dalam kondisi kering. Fokus di hidung, jangan buru-buru menilai rasa."
        case .aroma:
            "Siapkan referensi \(flavor), lalu bandingkan aromanya setelah kontak air panas. Tujuannya melatih transisi dry ke wet."
        case .taste:
            "Siapkan referensi \(flavor). Jika tidak ada, gunakan ingatan rasa yang mirip untuk bantu kalibrasi saat menyeruput."
        }
    }

    var stageSteps: [String] {
        switch stage {
        case .fragrance:
            [
                "Cium referensi \(flavor) dalam kondisi kering.",
                "Sebutkan 1-2 kata kunci aromanya (misal segar, manis, kacang).",
                "Cium bubuk kopimu lagi dan bandingkan."
            ]
        case .aroma:
            [
                "Cium referensi \(flavor), lalu cium kopi saat wet/bloom.",
                "Catat apakah aroma jadi lebih jelas atau berubah.",
                "Bandingkan lagi dengan fase dry untuk lihat kontras."
            ]
        case .taste:
            [
                "Cium atau icip referensi \(flavor) untuk kalibrasi cepat.",
                "Tahan sensasi itu di memori lidahmu.",
                "Icip kopimu lagi dengan teknik slurp."
            ]
        }
    }

    /// Informal hint (e.g. for future asset / copy).
    func imageLabel(for flavorName: String) -> String {
        switch flavorName.lowercased() {
        case "fruity": "jeruk/lemon"
        case "floral": "bunga mawar"
        case "nutty": "kacang/cokelat"
        case "sweet": "gula/madu"
        default: "referensi"
        }
    }
}
