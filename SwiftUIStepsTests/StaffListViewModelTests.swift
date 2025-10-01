//
//  StaffListViewModelTests.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/1/25.
//

import XCTest
import Combine
@testable import SwiftUISteps

final class StaffListViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()

    func testFetchStaffSuccess() {
        let mock = MockStaffRepository()
        let viewModel = StaffListViewModel(repository: mock)
        let expectation = XCTestExpectation(description: "Fetch Staffs")

        viewModel.$staffs
            .dropFirst()
            .sink { staffs in
                XCTAssertEqual(staffs.first?.name, "RaeHoon")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetch()
        wait(for: [expectation], timeout: 1.0)
    }
}
