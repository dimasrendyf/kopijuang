//
//  SensoryEvaluation.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 21/04/26.
//

import Foundation

enum AromaContrast: String, CaseIterable, Identifiable {
    case same = "Sama"
    case changed = "Berubah"
    case unsure = "Gak yakin"
    
    var id: String { rawValue }
}

struct SensoryEvaluation: Identifiable {
    let id = UUID()
    
    var beansName: String
    var grindSize: String
    var packagingNotes: String
    
    // State 1: Fragrance (Dry Coffee)
    var fragranceIntensity: Double // 1...10
    var fragranceCategory: FlavorCategory
    
    // State 2: Aroma (Wet Coffee / Bloom)
    var aromaContrast: AromaContrast
    var aromaIntensity: Double // 1...10
    var aromaCategory: FlavorCategory
    
    // State 3: Taste (Sip + Retronasal)
    var acidity: Double // 1...4
    var sweetness: Double // 1...4
    var mouthfeel: Double // 1...4
    var aftertaste: Double // 1...4
    var aftertasteDuration: Double // 1...5
}
