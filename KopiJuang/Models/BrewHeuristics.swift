//
//  BrewHeuristics.swift
//  Estimasi profil sensorik (skala 0–10) berbasis pola umum roast/process.
//  Selaras WCR/SCA sebagai panduan deskriptif, bukan standar skor kualitas.
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

    /// Satu kalimat untuk layar hasil.
    static func softTypicalLine(roast: String, process: String) -> String {
        let r = roast.lowercased()
        if r == "light" {
            return "Untuk \(roast) roast dengan proses \(process), acidity biasanya lebih mudah terbaca, sweetness bisa terasa ringan, bitterness cenderung rendah, dan body sering lebih ringan. Ini acuan deskriptif, bukan standar nilai."
        }
        if r == "dark" {
            return "Untuk \(roast) roast dengan proses \(process), body dan bitterness biasanya lebih mudah muncul, sementara acidity cenderung lebih rendah. Ini acuan deskriptif, bukan penilaian benar-salah."
        }
        return "Untuk \(roast) roast dengan proses \(process), acidity, sweetness, bitterness, dan body biasanya lebih seimbang. Pakai ini sebagai pembanding kasar, bukan target mutlak."
    }

    /// Paragraf saran seduhan.
    static func nextBrewGuidance(for evaluation: SensoryEvaluation) -> String {
        let e = expectation(roast: evaluation.roastLevel, process: evaluation.processLevel)
        let roast = evaluation.roastLevel
        let process = evaluation.processLevel
        let a = Int(evaluation.acidity.rounded())
        let sw = Int(evaluation.sweetness.rounded())
        let b = Int(evaluation.bitterness.rounded())
        let bo = Int(evaluation.bodyScore.rounded())

        var lines: [String] = [
            "Ini pembacaan kasar dari data seduhanmu: \(roast) roast, proses \(process). Bandingkan satu variabel per sesi agar perubahan rasa mudah kebaca."
        ]

        if !e.acidity.contains(a) {
            if a < e.acidity.lowerBound {
                lines.append(
                    "Acidity \(a) lebih rendah dari pola umum profil ini. Kalau cangkir terasa flat, coba giling sedikit lebih halus, naikkan suhu 1–2°C, atau tambah waktu kontak sedikit."
                )
            } else {
                lines.append(
                    "Acidity \(a) lebih tinggi dari pola umum profil ini. Kalau terasa menusuk, coba giling sedikit lebih kasar, turunkan suhu 1–2°C, atau pendekkan kontak air."
                )
            }
        }
        if !e.sweetness.contains(sw) {
            if sw < e.sweetness.lowerBound {
                lines.append(
                    "Sweetness \(sw) masih rendah. Kalau cangkir terasa tipis, coba perhalus grind sedikit atau tambah waktu kontak agar ekstraksi lebih lengkap."
                )
            } else {
                lines.append(
                    "Sweetness \(sw) menonjol. Jika cangkir tetap bersih dan nyaman, pertahankan resep. Kalau terlalu pekat, naikkan yield atau encerkan rasio sedikit."
                )
            }
        }
        if !e.bitterness.contains(b) {
            if b > e.bitterness.upperBound {
                lines.append(
                    "Bitterness \(b) lebih tinggi dari pola umum. Kalau pahitnya kasar, turunkan suhu, giling sedikit lebih kasar, atau pendekkan waktu kontak."
                )
            } else {
                lines.append(
                    "Bitterness \(b) rendah. Ini bisa bagus kalau cangkir tetap punya struktur. Kalau terasa kosong, tambah ekstraksi sedikit."
                )
            }
        }
        if !e.body.contains(bo) {
            if bo < e.body.lowerBound {
                lines.append(
                    "Body \(bo) terasa ringan untuk profil ini. Kalau ingin tekstur lebih tebal, pakai rasio sedikit lebih pekat atau giling sedikit lebih halus."
                )
            } else {
                lines.append(
                    "Body \(bo) terasa berat. Kalau terlalu pekat, pakai rasio lebih encer, giling sedikit lebih kasar, atau pendekkan kontak."
                )
            }
        }

        if lines.count == 1 {
            return lines[0] + " Skor kamu masih masuk pola umum. Kalau mau eksperimen, ubah satu hal saja: grind, suhu, rasio, atau waktu."
        }
        return lines.joined(separator: "\n\n")
    }
}
