//
//  ConcurrencyCombineViewModel.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/29/25.
//

/*
 - AsyncPublisher / .values
    - Timer.publish(...).autoconnect().values는 Combine Publisher를
 AsyncSequence로 변환해 for await 루프로 소비.

 - Future + Task
    - Future로 async 함수 loadMockData() 결과를 Publisher로 감쌈.
    - Combine 구독자는 sink로 간단히 받아볼 수 있음.

 - MainActor.run
    - UI 업데이트 시 반드시 메인 스레드에서 실행.
 */

import SwiftUI
import Combine

final class ConcurrencyCombineViewModel: ObservableObject {
    @Published var outputLog: [String] = []
    private var cancellables = Set<AnyCancellable>()

    // 1. Publisher -> Async/Await
    func startTimerAsync() {
        Task {
            // Timer를 Async 시퀀스로 변환
            for await value in Timer.publish(every: 1.0,
                                             on: .main,
                                             in: .common)
                                    .autoconnect()
                                    .values {
                await MainActor.run {
                    self.outputLog.append("Tick: \(value.formatted())")
                }
                if self.outputLog.count >= 5 { break }
            }
        }
    }

    // 2. Async -> Publisher
    func fetchData() -> AnyPublisher<String, Never> {
        Future { promise in
            Task {
                do {
                    let text = try await self.loadMockData()
                    promise(.success(text))
                } catch {
                    promise(.success("Error: \(error.localizedDescription)"))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    private func loadMockData() async throws -> String {
        try await Task.sleep(nanoseconds: 2_000_000_000) // 2초 지연
        return "Async result at \(Date().formatted())"
    }
}

extension ConcurrencyCombineViewModel {
    func fetchAlbum() -> AnyPublisher<Album, Error> {
        Future { promise in
            Task {
                do {
                    let url = URL(string: "https://jsonplaceholder.typicode.com/albums/1")!
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let album = try JSONDecoder().decode(Album.self, from: data)
                    promise(.success(album))
                } catch let error {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
