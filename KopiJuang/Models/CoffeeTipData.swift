//
//  CoffeeTipData.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 27/04/26.
//

import SwiftUI

enum CoffeeTipData {
    static let all: [CoffeeTip] = [
        CoffeeTip(
            icon: "thermometer.medium",
            iconColor: .orange,
            title: "Sensory Window",
            body: "Sensitivitas lidah terhadap asam & manis berada di puncak pada suhu 50–60°C. Sajikan kopi di rentang ini untuk evaluasi rasa terbaik.",
            source: "SCA"
        ),
        CoffeeTip(
            icon: "flame.fill",
            iconColor: .red,
            title: "Suhu Brewing Ideal",
            body: "Gunakan air 90–96°C saat brewing. Terlalu panas menyebabkan over-extraction (pahit), terlalu dingin menghasilkan under-extraction (asam datar).",
            source: "SCA"
        ),
        CoffeeTip(
            icon: "drop.fill",
            iconColor: .blue,
            title: "Golden Ratio",
            body: "Rasio ideal kopi ke air adalah 1:15 – 1:18 (1g kopi per 15–18ml air). Di luar rasio ini, rasa cenderung flat atau terlalu kuat.",
            source: "SCA"
        ),
        CoffeeTip(
            icon: "timer",
            iconColor: .purple,
            title: "Waktu Ekstraksi",
            body: "Target ekstraksi ideal adalah 18–22% dari berat kopi. Pour-over sebaiknya selesai dalam 2:30 – 3:30 menit untuk hasil terbaik.",
            source: "SCA"
        ),
        CoffeeTip(
            icon: "leaf.fill",
            iconColor: .green,
            title: "Kesegaran Biji",
            body: "Kopi mencapai puncak rasa 4–14 hari setelah roast. Setelah 30 hari, oksidasi mulai menurunkan kompleksitas aroma secara signifikan.",
            source: "WCR"
        ),
        CoffeeTip(
            icon: "cloud.fill",
            iconColor: .cyan,
            title: "Bloom / Pre-infusion",
            body: "TSebelum tuang semua air, siram dulu 2× berat kopi dan tunggu 30 detik. Lihat kopinya mengembang? Itu CO₂ keluar — tandanya kopi segar, dan ekstraksi akan lebih merata.",
            source: "SCA"
        ),
        CoffeeTip(
            icon: "chart.bar.fill",
            iconColor: .indigo,
            title: "TDS & Kekuatan Kopi",
            body: "TDS (banyak zat kopi yang terekstrak ke air) ideal untuk brewed coffee adalah 1.15–1.35%. Di bawah itu terasa encer, di atas itu terlalu pekat dan melelahkan di lidah.",
            source: "SCA"
        ),
        CoffeeTip(
            icon: "snowflake",
            iconColor: .mint,
            title: "Penyimpanan Biji",
            body: "Simpan biji kopi di wadah kedap udara, jauh dari cahaya & panas. Freezer boleh digunakan untuk stok jangka panjang, tapi hindari keluar-masuk berulang.",
            source: "WCR"
        )
    ]
}
