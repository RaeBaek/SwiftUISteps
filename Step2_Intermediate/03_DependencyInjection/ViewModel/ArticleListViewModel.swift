//
//  ArticleListViewModel.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/22/25.
//

import Combine
import SwiftUI

final class ArticleListViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private let service: ArticleServiceProtocol

    init(service: ArticleServiceProtocol) {
        self.service = service
    }

    func fetch() {
        isLoading = true
        errorMessage = nil

        // ① 네트워크 요청
        service.fetchArticles()
            .sink { [weak self] completion in
                guard let self else { return }
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] articles in
                guard let self else { return }
                self.articles = articles
            }
            .store(in: &cancellables)

        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000) // 1초
            await MainActor.run {
                self.isLoading = false
            }
        }
    }
}
