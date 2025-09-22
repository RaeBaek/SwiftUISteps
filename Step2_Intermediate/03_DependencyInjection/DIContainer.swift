//
//  DIContainer.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/22/25.
//

import Foundation

final class DIContainer {
    let articleService: ArticleServiceProtocol

    init(articleService: ArticleServiceProtocol) {
        self.articleService = articleService
    }

    func makeArticleListViewModel() -> ArticleListViewModel {
        return ArticleListViewModel(service: articleService)
    }
}
