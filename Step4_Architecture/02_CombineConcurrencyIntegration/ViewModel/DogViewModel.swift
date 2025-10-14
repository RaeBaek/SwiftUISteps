//
//  DogViewModel.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/14/25.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class DogViewModel: ObservableObject {
    @Published var dogs: [Dog] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let api = DogAPIAsync()
    private var cancellables = Set<AnyCancellable>()

    func fetchDogs() {
        isLoading = true
        errorMessage = nil

        // Combine 기반 Task 변환
        Task {
            do {
                let dogs = try await api.fetchDogs()
                self.dogs = dogs
            } catch {
                self.errorMessage = error.localizedDescription
            }
            self.isLoading = false
        }
    }

    // Combine -> async 변환 사용 예시
    func observeDogs(publisher: AnyPublisher<[Dog], Never>) {
        Task {
            for await value in publisher.values {
                self.dogs = value
            }
        }
    }
}
