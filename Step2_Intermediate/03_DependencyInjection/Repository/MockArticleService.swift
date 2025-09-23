//
//  MockArticleService.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/22/25.
//

import Foundation
import Combine

final class MockArticleService: ArticleServiceProtocol {
    var shouldFail = false

    func fetchArticles() -> AnyPublisher<[Article], Error> {
        if shouldFail {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        } else {
            let sample = [
                Article(id: 1, title: "Mock Headline", body: "Mock Content"),
                Article(id: 2, title: "Mock Headline", body: "Mock Content"),
                Article(id: 3, title: "Mock Headline", body: "Mock Content")
            ]
            return Just(sample)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
