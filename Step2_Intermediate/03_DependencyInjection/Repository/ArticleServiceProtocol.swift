//
//  ArticleServiceProtocol.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/22/25.
//

import Combine

protocol ArticleServiceProtocol {
    func fetchArticles() -> AnyPublisher<[Article], Error>
}
