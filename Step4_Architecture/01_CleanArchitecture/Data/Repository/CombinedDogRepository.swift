//
//  CombinedDogRepository.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/13/25.
//

import Foundation
import Combine
import os.log

final class CombinedDogRepository: DogRepository {
    private let remote: RemoteDogRepository
    private let local: LocalDogRepository

    private let logger = Logger(subsystem: "SwiftUISteps", category: "Repository")

    init(remote: RemoteDogRepository, local: LocalDogRepository) {
        self.remote = remote
        self.local = local
    }

    func fetchDogs() -> AnyPublisher<[Dog], NetworkError> {
        // 1️⃣ 로컬 캐시 즉시 반환
        let cached = local.load()
        let localPublisher = Just(cached)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()

        // 2️⃣ 네트워크 최신 데이터 요청
        let remotePublisher = remote.fetchDogs()
            .handleEvents(receiveOutput: { [weak self] dogs in
                guard let self else { return }
                self.local.save(dogs)
            })
            .catch { [weak self] (error: NetworkError) -> AnyPublisher<[Dog], NetworkError> in
                guard let self else { return Fail(error: error).eraseToAnyPublisher() }

                switch error {
                case .network(let urlErr):
                    // 네트워크 계열: 캐시 유지 (cached 재방출)
                    self.logger.warning("Network error, using cache: \(urlErr.localizedDescription)")

                    return Just<[Dog]>(cached)
                        .setFailureType(to: NetworkError.self)
                        .eraseToAnyPublisher()

                case .decoding(let decErr):
                    // 디코딩: 로그만 남기고 "빈 배열" 방출(혹은 Fail로 종료 선택 가능)
                    self.logger.error("Decoding error: \(decErr)")

                    // A) cached 방출
//                    return Just<[Dog]>(cached)
//                        .setFailureType(to: NetworkError.self)
//                        .eraseToAnyPublisher()

                    // B) 실패로 종료하고 싶다면
                    return Fail(error: NetworkError.decoding(decErr)).eraseToAnyPublisher()

                case .unknown(let err):
                    self.logger.error("Unknown error: \(err.localizedDescription)")

                    // A) cached 방출
//                    return Just<[Dog]>(cached)
//                        .setFailureType(to: NetworkError.self)
//                        .eraseToAnyPublisher()

                    // B) 실패로 종료하고 싶다면
                    return Fail(error: NetworkError.unknown(err)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()

        // 3️⃣ 합성 전략 (Local -> Remote 순서)
        return localPublisher
            .append(remotePublisher)
            .eraseToAnyPublisher()
    }
}
