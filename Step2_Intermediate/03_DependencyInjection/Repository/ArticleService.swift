//
//  ArticleService.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/22/25.
//

import Foundation
import Combine

final class ArticleService: ArticleServiceProtocol {
    func fetchArticles() -> AnyPublisher<[Article], Error> {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Article].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
