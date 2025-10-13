//
//  LocalDogRepository.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/13/25.
//

import Foundation
import Combine

/// UserDefaults 기반 캐시 구현
final class LocalDogRepository {
    private let key = "cachedDogs"

    func save(_ dogs: [Dog]) {
        if let data = try? JSONEncoder().encode(dogs) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func load() -> [Dog] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([Dog].self, from: data)
        else { return [] }

        return decoded
    }
}
