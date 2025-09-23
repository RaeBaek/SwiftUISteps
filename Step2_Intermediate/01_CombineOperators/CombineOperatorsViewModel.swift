//
//  CombineOperatorsViewModel.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/22/25.
//

import SwiftUI
import Combine

final class CombineOperatorsViewModel: ObservableObject {
    @Published var numbers: [Int] = []
    private var cancellables = Set<AnyCancellable>()

    func start() {
        // 1부터 10까지 발행, 짝수 filter 후 map * 2
        (1...10).publisher
            .filter { $0 % 2 == 0 }
            .map { $0 * 2 }
            .sink { [weak self] value in
                self?.numbers.append(value)
            }
            .store(in: &cancellables)
    }
}
