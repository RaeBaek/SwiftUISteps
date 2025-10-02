//
//  PerformanceTestView2.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/2/25.
//

/*
 - LazyVStack
   - SwiftUI 네이티브 레이아웃 시스템
   - 단순히 필요한 시점에만 View 생성
   - 초기 렌더링 시 오버헤드가 더 적음
 */

import SwiftUI

struct PerformanceTestView2: View {
    @StateObject private var viewModel = PerformanceViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Generating...")
            } else {
                // LazyVStack 사용
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 8) {
                        ForEach(viewModel.numbers) { num in
                            Text("Value: \(num.value)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 8)
                        }
                    }
                    .padding()
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
