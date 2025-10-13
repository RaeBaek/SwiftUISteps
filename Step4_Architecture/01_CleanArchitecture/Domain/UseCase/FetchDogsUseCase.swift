//
//  FetchDogsUseCase.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/13/25.
//

import Combine

protocol FetchDogsUseCase {
    func execute() -> AnyPublisher<[Dog], Error>
}

final class FetchDogsUseCaseImpl: FetchDogsUseCase {
    private let repository: DogRepository

    init(repository: DogRepository) {
        self.repository = repository
    }

    func execute() -> AnyPublisher<[Dog], Error> {
        repository.fetchDogs()
    }
}
