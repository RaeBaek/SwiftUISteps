//
//  NetworkingView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/22/25.
//

import SwiftUI

/*
 * Publisher 체인
  - dataTaskPublisher -> map -> decode -> receive(on:)
 * 에러 처리
  - .sink(receiveCompletion:)에서 .failure 분기
 * 메인 스레드 업데이트
  - .receive(on: DispatchQueue.main)로 UI 업데이트 안전 보장
 * MVVM 구조
  - Service -> ViewModel -> View로 역할 분리
 */

struct NetworkingView: View {
    @StateObject private var viewModel = NetworkingViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundStyle(.red)
                } else {
                    List(viewModel.posts) { post in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(post.title)
                                .font(.headline)
                            Text(post.body)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Posts")
            .task { // iOS 15+: View 등장 시 자동 실행
                viewModel.fetch()
            }
        }
    }
}

#Preview {
    NetworkingView()
}
