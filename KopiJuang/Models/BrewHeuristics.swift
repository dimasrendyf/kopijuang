//
//  BrewHeuristics.swift
//  Ekspektasi kasar 1–10 per roast+proses + saran bila jauh dari kisaran (bukan kebenaran absolut).
//

import Foundation

struct BrewMetricExpectation: Sendable {
    let acidity: ClosedRange<Int>
    let sweetness: ClosedRange<Int>
    let bitterness: ClosedRange<Int>
    let body: ClosedRange<Int>
}

enum BrewHeuristics: Sendable {
    static func expectation(roast: String, process: String) -> BrewMetricExpectation {
        let r = roast.lowercased()
        let p = normalizedProcess(process)

        switch (r, p) {
        case ("light", "wash"), ("light", "washed"):
            return BrewMetricExpectation(
                acidity: 5...8, sweetness: 4...6, bitterness: 2...4, body: 3...5
            )
        case ("light", "natural"):
            return BrewMetricExpectation(
                acidity: 5...8, sweetness: 5...7, bitterness: 2...4, body: 4...6
            )
        case ("light", "honey"):
            return BrewMetricExpectation(
                acidity: 5...7, sweetness: 5...7, bitterness: 2...4, body: 4...6
            )
        case ("light", "anaerobic"):
            return BrewMetricExpectation(
                acidity: 5...8, sweetness: 4...6, bitterness: 2...5, body: 3...5
            )
        case ("light", "wet hulled"):
            return BrewMetricExpectation(
                acidity: 3...5, sweetness: 3...5, bitterness: 3...5, body: 5...8
            )
        case ("medium", _):
            return BrewMetricExpectation(
                acidity: 4...6, sweetness: 4...6, bitterness: 3...5, body: 4...6
            )
        case ("dark", _):
            return BrewMetricExpectation(
                acidity: 2...4, sweetness: 3...5, bitterness: 5...8, body: 5...8
            )
        case ("omni", _):
            return BrewMetricExpectation(
                acidity: 4...6, sweetness: 4...6, bitterness: 3...6, body: 4...6
            )
        case ("light", _):
            return BrewMetricExpectation(
                acidity: 4...7, sweetness: 4...6, bitterness: 2...4, body: 3...6
            )
        default:
            return BrewMetricExpectation(
                acidity: 3...6, sweetness: 3...6, bitterness: 3...6, body: 3...6
            )
        }
    }

    private static func normalizedProcess(_ raw: String) -> String {
        let s = raw.lowercased()
        if s == "wash" { return "washed" }
        return s
    }

    /// Paragraf saran next seduh: membandingkan skor user vs kisaran tipikal roast+proses.
    static func nextBrewGuidance(for evaluation: SensoryEvaluation) -> String {
        let e = expectation(roast: evaluation.roastLevel, process: evaluation.processLevel)
        let roast = evaluation.roastLevel
        let process = evaluation.processLevel
        let a = Int(evaluation.acidity.rounded())
        let sw = Int(evaluation.sweetness.rounded())
        let b = Int(evaluation.bitterness.rounded())
        let bo = Int(evaluation.bodyScore.rounded())

        var lines: [String] = [
            "Patokan tipikal untuk \(roast) + \(process) (bukan wajib): asam dalam \(e.acidity), manis \(e.sweetness), pahit \(e.bitterness), body \(e.body) pada skala 1–10."
        ]

        if !e.acidity.contains(a) {
            if a < e.acidity.lowerBound {
                lines.append(
                    "Asam skor \(a) di bawah kisaran tipikal \(e.acidity). Sering: terlalu encer, suhu landai, atau giling terlalu kasar. Coba: perketat grind sedikit, naik suhu 1–2°C, atau pekatkan rasio—ubah satu variabel, banding slurp."
                )
            } else {
                lines.append(
                    "Asam skor \(a) di atas kisaran tipikal \(e.acidity). Coba: grind sedikit kasar, turun suhu 1–2°C, atau batasi waktu terekstraksi; cek pula apakah cangkir/ferment tajam alami."
                )
            }
        }

        if !e.sweetness.contains(sw) {
            if sw < e.sweetness.lowerBound {
                lines.append(
                    "Manis skor \(sw) jauh di bawah kisaran \(e.sweetness). Coba ekstraksi agak penuh (halus, suhu, waktu) atau tinjau cangkir bila proses alami: yang dicari bukan gula, tapi rasa penuh/bulat."
                )
            } else {
                lines.append(
                    "Manis skor \(sw) jauh di atas kisaran \(e.sweetness). Cek penuangan terlalu lama, rasio pekat, atau cangkir yang manis tajam; seimbangi dengan waktu/final yield."
                )
            }
        }

        if !e.bitterness.contains(b) {
            if b > e.bitterness.upperBound {
                lines.append(
                    "Pahit skor \(b) jauh di atas kisaran tipikal \(e.bitterness). Coba turun suhu, grind kasar sedikit, batasi waktu kontak, atau cegah over-extraction (gerakan, ukuran penuang)."
                )
            } else {
                lines.append(
                    "Pahit skor \(b) jauh di bawah kisaran tipikal \(e.bitterness). Untuk roast gelap sering wajar; untuk terang–medium bisa berarti ekstraksi masih kurang atau cangkir memang rendah pahit—sesuaikan dengan profil yang kamu cari."
                )
            }
        }

        if !e.body.contains(bo) {
            if bo < e.body.lowerBound {
                lines.append(
                    "Body skor \(bo) di bawah kisaran tipikal \(e.body). Coba grind halus sedikit, rasio agak pekat, atau waktu/sedikit lebih lama; pastikan cangkir/tekstur cairan sesuai."
                )
            } else {
                lines.append(
                    "Body skor \(bo) di atas kisaran tipikal \(e.body). Coba grind kasar, perpendek ekstraksi, atau cek apakah over-extract."
                )
            }
        }

        if lines.count == 1 {
            return lines[0] + " Skor kamu cukup dekat kisaran—sesi berikut cukup ubah satu variabel (rasio, suhu, grind, atau waktu) agar bedanya terasa jelas."
        }
        return lines.joined(separator: "\n\n")
    }
}
