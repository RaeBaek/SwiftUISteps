//
//  NetworkingViewModel.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/22/25.
//

import Combine
import SwiftUI

final class NetworkingViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private var service: PostServiceProtocol

    init(service: PostServiceProtocol = PostService()) {
        self.service = service
    }

    func fetch() {
        isLoading = true
        errorMessage = nil

        // ① 네트워크 요청
        service.fetchPosts()
            .sink { [weak self] completion in
                guard let self else { return }
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] posts in
                guard let self else { return }
                self.posts = posts
            }
            .store(in: &cancellables)

        // ② 최소 1초 동안 로딩 유지
        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000) // 1초
            await MainActor.run {
                self.isLoading = false
            }
        }
    }

    func makeError() {
        isLoading = false
        errorMessage = "Network Error"
    }
}
