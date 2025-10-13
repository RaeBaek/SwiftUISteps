//
//  Dog.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/13/25.
//

import Foundation

struct Dog: Decodable {
    let id: String
    let type: String
    let attributes: Arrtibutes
    let relationships: RelationShips
}

struct Arrtibutes: Decodable {
    let name: String
    let description: String
    let life: Life
    let maleWeight: MaleWeight
    let femaleWeight: FemaleWeight
    let hypoallergenic: Bool

    enum CodingKeys: String, CodingKey {
        case name, description, life, hypoallergenic
        case maleWeight = "male_weight"
        case femaleWeight = "female_weight"
    }
}

struct Life: Decodable {
    let max: Int
    let min: Int
}

struct MaleWeight: Decodable {
    let max: Int
    let min: Int
}

struct FemaleWeight: Decodable {
    let max: Int
    let min: Int
}

struct RelationShips: Decodable {
    let group: Group
}

struct Group: Decodable {
    let data: Data
}

struct Data: Decodable {
    let id: String
    let type: String
}
