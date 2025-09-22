//
//  SearchViewModel.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/22/25.
//

import SwiftUI
import Combine

final class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var results: [String] = []
    private var cancellables = Set<AnyCancellable>()

    init() {
        $query
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                guard let self else { return }
                self.results = self.mockSearch(text: text)
            }
            .store(in: &cancellables)
    }

    private func mockSearch(text: String) -> [String] {
        guard !text.isEmpty else { return [] }
        return ["Swift", "Combine", "Concurrency", "SwiftUI"]
            .filter { $0.lowercased().contains(text.lowercased()) }
    }
}
