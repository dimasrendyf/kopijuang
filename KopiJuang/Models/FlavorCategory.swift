//
//  FlavorCategory.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 21/04/26.
//

import Foundation

enum FlavorCategory: String, CaseIterable, Identifiable {
    case fruity = "Fruity"
    case floral = "Floral"
    case nutty = "Nutty"
    case sweet = "Sweet"
    
    var id: String { rawValue }
}

