//
//  FlavorWheelNode.swift
//  KopiJuang
//

import Foundation

struct FlavorWheelNode: Identifiable {
    let id: String
    let name: String
    let description: String
    let layer: Int
    let parent: String?
    let children: [FlavorWheelNode]
    
    // Helper statis untuk mengambil node berdasar id
    static func findNode(by id: String, in nodes: [FlavorWheelNode] = FlavorWheelData.wheel) -> FlavorWheelNode? {
        for node in nodes {
            if node.id.lowercased() == id.lowercased() {
                return node
            }
            if let found = findNode(by: id, in: node.children) {
                return found
            }
        }
        return nil
    }
}

struct FlavorWheelData {
    static let wheel: [FlavorWheelNode] = [
        FlavorWheelNode(id: "fruity", name: "Fruity", description: "Rasa seperti buah-buahan segar atau manis alami", layer: 1, parent: nil, children: [
            FlavorWheelNode(id: "berry", name: "Berry", description: "Rasa buah berry yang asam manis", layer: 2, parent: "fruity", children: [
                FlavorWheelNode(id: "blackberry", name: "Blackberry", description: "Manis gelap dan sedikit asam", layer: 3, parent: "berry", children: []),
                FlavorWheelNode(id: "raspberry", name: "Raspberry", description: "Asam segar khas merah", layer: 3, parent: "berry", children: []),
                FlavorWheelNode(id: "blueberry", name: "Blueberry", description: "Manis dan sangat khas", layer: 3, parent: "berry", children: []),
                FlavorWheelNode(id: "strawberry", name: "Strawberry", description: "Manis segar seperti stroberi", layer: 3, parent: "berry", children: [])
            ]),
            FlavorWheelNode(id: "citrus_fruit", name: "Citrus Fruit", description: "Kelompok buah sitrus yang asam terang", layer: 2, parent: "fruity", children: [
                FlavorWheelNode(id: "grapefruit", name: "Grapefruit", description: "Asam sedikit pahit", layer: 3, parent: "citrus_fruit", children: []),
                FlavorWheelNode(id: "apple", name: "Apple", description: "Asam manis renyah", layer: 3, parent: "citrus_fruit", children: []),
                FlavorWheelNode(id: "lemon", name: "Lemon", description: "Asam kuat dan tajam", layer: 3, parent: "citrus_fruit", children: []),
                FlavorWheelNode(id: "lime", name: "Lime", description: "Asam kecut segar", layer: 3, parent: "citrus_fruit", children: [])
            ])
        ]),
        FlavorWheelNode(id: "floral", name: "Floral", description: "Rasa menyerupai wangi bunga", layer: 1, parent: nil, children: [
            FlavorWheelNode(id: "black_tea", name: "Black Tea", description: "Karakter teh hitam", layer: 2, parent: "floral", children: []),
            FlavorWheelNode(id: "chamomile", name: "Chamomile", description: "Bunga chamomile lembut", layer: 2, parent: "floral", children: []),
            FlavorWheelNode(id: "rose", name: "Rose", description: "Wangi mawar", layer: 2, parent: "floral", children: []),
            FlavorWheelNode(id: "jasmine", name: "Jasmine", description: "Wangi melati", layer: 2, parent: "floral", children: [])
        ]),
        FlavorWheelNode(id: "nutty", name: "Nutty", description: "Rasa gurih seperti kacang-kacangan", layer: 1, parent: nil, children: [
            FlavorWheelNode(id: "nut", name: "Nut", description: "Karakter kacang umum", layer: 2, parent: "nutty", children: [
                FlavorWheelNode(id: "peanuts", name: "Peanuts", description: "Kacang tanah panggang", layer: 3, parent: "nut", children: []),
                FlavorWheelNode(id: "hazelnut", name: "Hazelnut", description: "Gurih manis hazelnut", layer: 3, parent: "nut", children: []),
                FlavorWheelNode(id: "almond", name: "Almond", description: "Kacang almond renyah", layer: 3, parent: "nut", children: [])
            ]),
            FlavorWheelNode(id: "cocoa", name: "Cocoa", description: "Cokelat atau kakao", layer: 2, parent: "nutty", children: [
                FlavorWheelNode(id: "chocolate", name: "Chocolate", description: "Cokelat manis/susu", layer: 3, parent: "cocoa", children: []),
                FlavorWheelNode(id: "dark_chocolate", name: "Dark Chocolate", description: "Cokelat hitam pekat dan pahit", layer: 3, parent: "cocoa", children: [])
            ])
        ]),
        FlavorWheelNode(id: "sweet", name: "Sweet", description: "Rasa manis alami", layer: 1, parent: nil, children: [
            FlavorWheelNode(id: "brown_sugar", name: "Brown Sugar", description: "Manis karamel/gula aren", layer: 2, parent: "sweet", children: [
                FlavorWheelNode(id: "molasses", name: "Molasses", description: "Gula pekat", layer: 3, parent: "brown_sugar", children: []),
                FlavorWheelNode(id: "maple_syrup", name: "Maple Syrup", description: "Sirup maple", layer: 3, parent: "brown_sugar", children: []),
                FlavorWheelNode(id: "caramel", name: "Caramel", description: "Karamel leleh", layer: 3, parent: "brown_sugar", children: []),
                FlavorWheelNode(id: "honey", name: "Honey", description: "Madu alami", layer: 3, parent: "brown_sugar", children: [])
            ]),
            FlavorWheelNode(id: "vanilla", name: "Vanilla", description: "Vanila aromatik", layer: 2, parent: "sweet", children: [])
        ])
    ]
}
