//
//  FetchDogUseCaseTests.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/13/25.
//

import XCTest
import Combine

/// MockRepository & UseCase 테스트
final class MockDogRepository: DogRepository {
    var subject = PassthroughSubject<[Dog], NetworkError>()

    func fetchDogs() -> AnyPublisher<[Dog], NetworkError> {
        subject.eraseToAnyPublisher()
    }
}

final class FetchDogUseCaseTests: XCTestCase {
    private var cancellabels = Set<AnyCancellable>()

    func testUseCaseEmitsDogs() {
        let repo = MockDogRepository()
        let useCase = FetchDogsUseCaseImpl(repository: repo)
        let exp = expectation(description: "dogs")

        useCase.execute()
            .sink(receiveCompletion: { _ in }, receiveValue: { dogs in
                XCTAssertFalse(dogs.isEmpty)
                exp.fulfill()
            })
            .store(in: &cancellabels)

        repo.subject.send(
            [Dog(
                id: "1",
                type: "breed",
                name: "Hound",
                description: "Nice",
                life: "10 ~ 12",
                maleWeight: "10 ~ 12",
                femaleWeight: "10 ~ 12",
                hypoallergenic: true
            )]
        )
        wait(for: [exp], timeout: 1.0)
    }
}
