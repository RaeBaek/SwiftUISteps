//
//  CombineAdvanceViewModel.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/26/25.
//

import Combine
import SwiftUI

final class CombineAdvanceViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var isValid = false
    @Published var timeString = ""
    @Published var user: User?

    private var cancellables = Set<AnyCancellable>()


    init() {
        // ① CombineLatest
        Publishers.CombineLatest($username, $password)
            .map { !$0.isEmpty && $1.count >= 6 }
            .assign(to: &$isValid)

        // ② merge + throttle
        let fastTimer = Timer.publish(every: 0.3, on: .main, in: .default).autoconnect()
        let slowTimer = Timer.publish(every: 0.7, on: .main, in: .default).autoconnect()

        Publishers.Merge(fastTimer, slowTimer)
            .map { _ in
                Date().formatted(date: .omitted, time: .standard)
            }
            .throttle(for: .seconds(1.5), scheduler: RunLoop.main, latest: true)
            .assign(to: &$timeString)
    }

    // ③ 에러 복구
    func fetchWithRetry() {
        URLSession.shared.dataTaskPublisher(
            for: URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        )
        .tryMap { data, _ in
            guard let user = try? JSONDecoder().decode(User.self, from: data) else {
                throw URLError(.badServerResponse)
            }
            return user
        }
        .retry(3)
        .catch { _ in
            Just(User(userId: 0, id: 0, title: "No Data", body: "No Data"))
        }
        .sink { [weak self] user in
            guard let self else { return }
            self.user = user
        }
        .store(in: &cancellables)
    }

}

