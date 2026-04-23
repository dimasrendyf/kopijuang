//
//  CoffeeSetupViewModel.swift
//  KopiJuang
//

import Foundation
import Observation

@MainActor
@Observable
final class CoffeeSetupViewModel {
    var beanName: String = ""
    var beanOrigin: String = ""
    var roastLevel: String = ""
    var processLevel: String = ""

    let roastOptions: [String] = ["Light", "Medium", "Dark", "Omni"]
    let processOptions: [String] = ["Natural", "Wash", "Honey", "Anaerobic", "Wet Hulled"]

    var canStart: Bool {
        !beanName.isEmpty && !roastLevel.isEmpty && !processLevel.isEmpty
    }

    var showBeanInsight: Bool { !roastLevel.isEmpty && !processLevel.isEmpty }

    func roastDescription(for level: String) -> String {
        switch level {
        case "Light": "Acidity lebih terbaca, body ringan, notes origin lebih jelas."
        case "Medium": "Balance antara acidity dan body."
        case "Dark": "Body tebal, bitterness dominan, notes roast (cokelat, smoky)."
        case "Omni": "Fleksibel untuk filter maupun espresso."
        default: ""
        }
    }

    func processDescription(for process: String) -> String {
        switch process {
        case "Natural": "Cenderung fruity, body lebih tebal, sweetness tinggi."
        case "Wash": "Clean, acidity lebih jelas, notes lebih defined."
        case "Honey": "Di antara natural dan washed, sweetness menonjol."
        case "Anaerobic": "Notes eksotik, seringkali ada karakter fermentasi/winey."
        case "Wet Hulled": "Body sangat tebal, acidity rendah, notes earthy/spicy khas Indonesia."
        default: ""
        }
    }

    func focusHint(roast: String, process: String) -> String {
        switch (roast.lowercased(), process.lowercased()) {
        case ("light", "natural"):
            "cek acidity cerah + sweetness fruity."
        case ("light", "wash"), ("light", "washed"):
            "cek kejernihan acidity dan clean finish."
        case ("dark", _):
            "cek body, bitterness, dan ketebalan aftertaste."
        case (_, "honey"):
            "cek sweetness round dan mouthfeel nyaman."
        case (_, "wet hulled"):
            "cek body tebal dan earthy note."
        default:
            "cek keseimbangan acidity, sweetness, bitterness, dan body."
        }
    }
}
