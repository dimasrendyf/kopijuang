//
//  CoffeeBean.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 10/04/26.
//

import Foundation

struct CoffeeBean: Identifiable {
    let id = UUID()
    var name: String
    var notes: String
    var grind_size: String
}
