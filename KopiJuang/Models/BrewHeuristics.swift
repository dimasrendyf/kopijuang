//
//  BrewHeuristics.swift
//  Estimasi profil sensorik (skala 1–10) berdasarkan roast dan proses. Saran adalah referensi, bukan aturan mutlak.
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
            return "Untuk level sangrai \(roast) dengan proses \(process), profil asam biasanya lebih dominan, diikuti oleh kemanisan. Pahit cenderung minimal dengan *body* yang berada di rentang medium. Skala 1–10 ini adalah referensi umum, bukan patokan mutlak."
        }
        if r == "dark" {
            return "Untuk level sangrai \(roast) dengan proses \(process), *body* dan kepahitan akan lebih menonjol, sementara tingkat keasaman cenderung rendah. Skala 1–10 ini digunakan untuk membantu Anda memahami pola rasa, bukan penilaian benar-salah."
        }
        return "Untuk level sangrai \(roast) dengan proses \(process), profil rasa (asam, manis, pahit) serta *body* biasanya berada dalam keseimbangan. Skala 1–10 ini merupakan acuan pengecapan, bukan target mutlak."
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
            "Berikut analisis hasil seduhan Anda untuk profil sangrai \(roast) dan proses \(process). Angka-angka ini adalah perbandingan dengan kebiasaan umum dalam pengecapan, bukan rumus kaku."
        ]

        if !e.acidity.contains(a) {
            if a < e.acidity.lowerBound {
                lines.append(
                    "Skor keasaman: \(a) berada di bawah rata-rata. Hal ini sering terjadi jika ekstraksi kurang optimal (under-extracted) akibat gilingan yang terlalu kasar, suhu air rendah, atau rasio yang kurang tepat. Coba perhalus ukuran gilingan atau naikkan suhu air 1–2°C pada seduhan berikutnya."
                )
            } else {
                lines.append(
                    "Skor keasaman: \(a) terasa cukup tajam. Jika intensitasnya sudah tidak nyaman (menusuk), pertimbangkan untuk menggiling sedikit lebih kasar atau menurunkan suhu air 1–2°C. Pastikan juga kualitas biji tidak memiliki indikasi cacat fermentasi."
                )
            }
        }
        if !e.sweetness.contains(sw) {
            if sw < e.sweetness.lowerBound {
                lines.append(
                    "Skor kemanisan: \(sw) terasa kurang menonjol. Kemanisan dalam kopi adalah sensasi 'penuh' (fullness) di mulut. Jika terasa tipis, coba optimalkan variabel ekstraksi seperti suhu atau waktu kontak untuk meningkatkan intensitasnya."
                )
            } else {
                lines.append(
                    "Skor kemanisan: \(sw) terasa sangat menonjol. Ini bisa menjadi indikasi ekstraksi yang sangat baik, atau justru konsentrasi yang terlalu tinggi. Jika terasa terlalu intens, Anda bisa menyesuaikan *yield* atau waktu penuangan."
                )
            }
        }
        if !e.bitterness.contains(b) {
            if b > e.bitterness.upperBound {
                lines.append(
                    "Skor kepahitan: \(b) berada di atas batas nyaman untuk profil ini. Untuk mengurangi indikasi *over-extraction*, coba turunkan suhu air, gunakan gilingan sedikit lebih kasar, atau perpendek waktu kontak air."
                )
            } else {
                lines.append(
                    "Skor kepahitan: \(b) terasa sangat rendah. Pada roast gelap, ini mungkin wajar. Namun, pada roast terang atau menengah, ini bisa mengindikasikan ekstraksi yang belum maksimal."
                )
            }
        }
        if !e.body.contains(bo) {
            if bo < e.body.lowerBound {
                lines.append(
                    "Skor *body*: \(bo) terasa lebih encer dari ekspektasi. Coba gunakan gilingan yang sedikit lebih halus atau tingkatkan rasio kopi terhadap air (lebih pekat) untuk menambah tekstur pada cangkir Anda."
                )
            } else {
                lines.append(
                    "Skor *body*: \(bo) terasa cukup berat. Jika dirasa terlalu intens, coba giling sedikit lebih kasar atau kurangi waktu kontak untuk mendapatkan hasil yang lebih ringan."
                )
            }
        }

        if lines.count == 1 {
            return lines[0] + " Hasil seduhan Anda berada dalam rentang ekspektasi. Jika ingin bereksperimen, ubah satu variabel saja (seperti rasio atau ukuran gilingan) agar perubahan pada profil rasa lebih terukur."
        }
        return lines.joined(separator: "\n\n")
    }
}
