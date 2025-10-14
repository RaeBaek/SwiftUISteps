//
//  RemoteDogRepository.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/13/25.
//

import Foundation
import Combine

final class RemoteDogRepository: DogRepository {
    private let api: DogAPI

    init(api: DogAPI) {
        self.api = api
    }

    func fetchDogs() -> AnyPublisher<[Dog], NetworkError> {
        api.fetchAPI()
    }
}
