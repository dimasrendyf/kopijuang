//
//  CoffeeSession.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 20/04/26.
//

import Foundation

// this model for history coffees
struct CoffeeSession: Identifiable {
    let id = UUID()
    let title: String
    let flavor: String
    var isCompleted: Bool
}
