//
//  CombinedDogRepository.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/13/25.
//

import Foundation
import Combine

final class CombinedDogRepository: DogRepository {
    private let remote: RemoteDogRepository
    private let local: LocalDogRepository

    init(remote: RemoteDogRepository, local: LocalDogRepository) {
        self.remote = remote
        self.local = local
    }

    func fetchDogs() -> AnyPublisher<[Dog], Error> {
        // 1️⃣ 로컬 캐시 즉시 반환
        let localDogs = local.load()
        let localPublisher = Just(localDogs)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()

        // 2️⃣ 네트워크 최신 데이터 요청
        let remotePublisher = remote.fetchDogs()
            .handleEvents(receiveOutput: { [weak self] dogs in
                guard let self else { return }
                self.local.save(dogs)
            })
            .catch { _ in // 에러 발생 시, 빈 배열 또는 기존 캐시 반환
                Just(localDogs)
                    .setFailureType(to: Error.self)
            }
            .eraseToAnyPublisher()

        // 3️⃣ 합성 전략 (Local -> Remote 순서)
        return localPublisher
            .append(remotePublisher)
            .eraseToAnyPublisher()
    }
}
