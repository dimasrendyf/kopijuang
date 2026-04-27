//
//  CoffeeTip.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 27/04/26.
//

import Foundation
import SwiftUI

struct CoffeeTip: Identifiable {
    let id = UUID()
    let icon: String
    let iconColor: Color
    let title: String
    let body: String
    let source: String
}
