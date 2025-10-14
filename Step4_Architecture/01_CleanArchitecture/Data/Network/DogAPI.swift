//
//  DogAPI.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/13/25.
//

/*
 1. 다양한 에러를 NetworkError로 변환
 2. Data 레이어부터 Failure 타입을 Network로 통일하면 이후 분기가 쉬워짐
 */

import Foundation
import Combine

struct DogAPI {
    func fetchAPI() -> AnyPublisher<[Dog], NetworkError> {
        let url = URL(string: "https://dogapi.dog/api/v2/breeds?page[number]=1")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: DataDTO.self, decoder: JSONDecoder())
            .map { $0.data.map { $0.toDomain }}
            .mapError { error -> NetworkError in
                switch error {
                case let urlError as URLError:
                    return .network(urlError)
                case let decoding as DecodingError:
                    return .decoding(decoding)
                default:
                    return .unknown(error)
                }
            }
            .eraseToAnyPublisher()
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
