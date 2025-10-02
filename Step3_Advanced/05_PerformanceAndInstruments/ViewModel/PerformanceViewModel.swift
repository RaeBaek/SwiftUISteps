//
//  PerformanceViewModel.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/2/25.
//

/*
 1. 성능 이슈를 일부러 만들어보기
   - 무거운 연산 (예: 큰 배열 정렬, 이미지 필터링, JSON 파싱 등)
   - SwiftUI View가 불필요하게 다시 그려지는 상황
 2. Instruments 활용
   - Time Profiler -> CPU 사용량 확인
   - Allocations / Leaks -> 메모리 확인
   - SwiftUI View Body Updates -> 과도한 렌더링 추적
 3. 최적화 기법
   - @StateObject vs @ObservedObject 차이 확인
   - EqutableView, @Equatable 로 불필요한 리렌더링 방지
   - Task(priority:), background thread 로 무거운 연산 분리
   - 캐싱 적용 (예: NSCache)
 */

import Foundation
import Combine

final class PerformanceViewModel: ObservableObject {
    @Published var numbers: [HeavyModel] = []
    @Published var isLoading = false

    func generateHeavyData() {
        isLoading = true
        DispatchQueue.global().async {
            let data = (0..<100_000).map { HeavyModel(value: $0) }
            DispatchQueue.main.async {
                self.numbers = data
                self.isLoading = false
            }
        }
    }
}
