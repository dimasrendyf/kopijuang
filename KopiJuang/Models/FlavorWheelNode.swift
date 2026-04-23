//
//  FlavorWheelNode.swift
//  KopiJuang
//

import Foundation

struct FlavorWheelNode: Identifiable, Sendable {
    let id: String
    let name: String
    let description: String
    let layer: Int
    let parent: String?
    let children: [FlavorWheelNode]

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
