//
//  ArticleListViewModelTests.swift
//  SwiftUIStepsTests
//
//  Created by 백래훈 on 9/23/25.
//

import XCTest
import Combine
@testable import SwiftUISteps

/*
 - @testable import: 앱 모듈 내부 타입을 테스트에서 접근 가능
 - XCTestExpectation: Combine의 비동기 스트림을 기다리기 위해 필요
 - dropFirst(): @Published 프로퍼티는 초기 값도 바로 발행되므로, 실제 변경 이벤트만 관찰하기 위해 사용
 - MockArticleService: 네트워크를 완전히 배제하고 결과를 제어 -> 빠르고 안정적인 테스트

 - Mock Repository를 ArticleServiceProtocol로 주입
 - XCTest에서 viewModel을 직접 생성 -> fetch() 호출
 - Combine 구독으로 결과 검증 (sink, XCTestExpectation)
 */

final class ArticleListViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()

    func testFetchArticlesSuccess() {
        // Given
        let mockService = MockArticleService()
        let viewModel = ArticleListViewModel(service: mockService)
        let expectation = XCTestExpectation(description: "Fetch Articles")

        // When
        viewModel.$isLoading
            .dropFirst() // 초기 [] 값은 무시
            .filter { !$0 }
            .sink { isLoading in
                // Then
                XCTAssertFalse(isLoading)
                XCTAssertNil(viewModel.errorMessage)
                XCTAssertEqual(viewModel.articles.first?.title, "Mock Headline")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetch()
        wait(for: [expectation], timeout: 2.0)
    }

    func testFetchArticlesFailure() {
        // Given
        let mockService = MockArticleService()
        mockService.shouldFail = true
        let viewModel = ArticleListViewModel(service: mockService)
        let expectation = XCTestExpectation(description: "Fetch Fail")

        // When
        viewModel.$isLoading
            .dropFirst()
            .filter { !$0 }
            .sink { isLoading in
                // Then
                XCTAssertFalse(isLoading)
                XCTAssertNotNil(viewModel.errorMessage)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetch()
        wait(for: [expectation], timeout: 2.0)

    }
}
