//
//  PostService.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/22/25.
//

import Combine
import Foundation

struct Post: Identifiable, Codable {
    let id: Int
    let title: String
    let body: String
}

protocol PostServiceProtocol {
    func fetchPosts() -> AnyPublisher<[Post], Error>
}

final class PostService: PostServiceProtocol {
    func fetchPosts() -> AnyPublisher<[Post], Error> {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
