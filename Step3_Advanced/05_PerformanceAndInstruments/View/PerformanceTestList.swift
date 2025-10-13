//
//  PerformanceTestList.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/2/25.
//

/*
 - List
   - 내부적으로 UIKit의 UITableView 기반
   - 셀 재사용, 스크롤 최적화 기능이 있지만 -> 초기 레이아웃 계산과 브리징 비용이 큼
 */

import SwiftUI

struct PerformanceTestList: View {
    @StateObject private var viewModel = PerformanceViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Generating...")
            } else {
                // List 사용
                List(viewModel.numbers) { num in
                    Text("Value: \(num.value)")
                }
            }

            Button("Generate Heavy Data") {
                viewModel.generateHeavyData()
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Performance Test")
    }
}
