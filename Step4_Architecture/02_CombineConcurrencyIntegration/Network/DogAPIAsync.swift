//
//  DogAPIAsync.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/14/25.
//

import Foundation
import Combine

struct DogAPIAsync {
    func fetchDogs() async throws -> [Dog] {
        let url = URL(string: "https://dogapi.dog/api/v2/breeds?page[number]=1")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(DataDTO.self, from: data).data.map { $0.toDomain }
    }
}

// DTO ↔ Domain
private struct DataDTO: Decodable {
    let data: [Breed]
}

private struct Breed: Decodable {
    let id: String
    let type: String
    let attributes: Arrtibutes
    let relationships: RelationShips
}

private extension Breed {
    var toDomain: Dog {
        Dog(
            id: id,
            type: type,
            name: attributes.name,
            description: attributes.description,
            life: "\(attributes.life.min) ~ \(attributes.life.max) age",
            maleWeight: "\(attributes.maleWeight.min) ~ \(attributes.maleWeight.max)kg",
            femaleWeight: "\(attributes.femaleWeight.min) ~ \(attributes.femaleWeight.max)kg",
            hypoallergenic: attributes.hypoallergenic
        )
    }
}

private struct Arrtibutes: Decodable {
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

private struct Life: Decodable {
    let max: Int
    let min: Int
}

private struct MaleWeight: Decodable {
    let max: Int
    let min: Int
}

private struct FemaleWeight: Decodable {
    let max: Int
    let min: Int
}

private struct RelationShips: Decodable {
    let group: Group
}

private struct Group: Decodable {
    let data: Data
}

private struct Data: Decodable {
    let id: String
    let type: String
}
