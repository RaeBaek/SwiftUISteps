//
//  StaffListViewModel.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/1/25.
//

/*
 1. receiveCompletion 클로저
   - 이 클로저는 completion 이벤트(성공/실패)와 함께 한 번만 호출되고 종료됨
   - 한 번 불린 뒤에는 더 이상 유지되지 않고, 순환 참조가 형성될 구조도 아님
 2. receiveValue 클로저
   - receiveValue는 데이터 스트림이 살아 있는 동안 여러 번 호출될 수 있는 클로저
   - Publisher <-> Subscriber <-> ViewModel 간에 강한 참조 사이클이 생길 수 있음
   - 특히 ViewModel이 사라져야 하는 상황에서도 스트림이 self를 붙잡고 놓지 않을 수 있음
   - 그래서 [weak self]를 넣어 순환 참조 가능성을 제거
 */

import Foundation
import Combine

final class StaffListViewModel: ObservableObject {
    @Published var staffs: [Staff] = []
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private let repository: StaffRepository

    init(repository: StaffRepository) {
        self.repository = repository
    }

    func fetch() {
        repository.fetchStaffs()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] staffs in
                self?.staffs = staffs
            })
            .store(in: &cancellables)

    }
}
