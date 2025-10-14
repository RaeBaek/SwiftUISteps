//
//  DogListViewModelTests.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/13/25.
//

import XCTest
import Combine

/// ViewModel 테스트 (성공 케이스)
final class DogListViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()

    // 고정된 응답만을 반환하는 단순 객체
    struct StubUseCase: FetchDogsUseCase {
        func execute() -> AnyPublisher<[Dog], NetworkError> {
            Just([Dog(
                id: "1",
                type: "breed",
                name: "Hound",
                description: "Nice",
                life: "10 ~ 12",
                maleWeight: "10 ~ 12",
                femaleWeight: "10 ~ 12",
                hypoallergenic: true
            )])
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
        }
    }

    func testLoadSuccess() {
        let viewModel = DogListViewModel(fetchDogs: StubUseCase())
        let exp = expectation(description: "loaded") // ① 기대 생성

        viewModel.$dogs
            .dropFirst()
            .sink { dogs in
                XCTAssertEqual(dogs.count, 1)
                exp.fulfill() // ② 완료 신호
            }
            .store(in: &cancellables)

        viewModel.load()
        wait(for: [exp], timeout: 1.0) // ③ 기다리기
    }
}
