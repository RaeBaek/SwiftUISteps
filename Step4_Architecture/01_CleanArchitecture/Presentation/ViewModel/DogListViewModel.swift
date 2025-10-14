//
//  DogListViewModel.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/13/25.
//

import Combine
import SwiftUI

final class DogListViewModel: ObservableObject {
    @Published var dogs: [Dog] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private let fetchDogs: FetchDogsUseCase

    init(fetchDogs: FetchDogsUseCase) {
        self.fetchDogs = fetchDogs
    }

    func load() {
        isLoading = true
        errorMessage = nil

        fetchDogs.execute()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = error.errorDescription
                }
            }, receiveValue: { [weak self] dogs in
                guard let self else { return }
                self.dogs = dogs
            })
            .store(in: &cancellables)
    }
}
