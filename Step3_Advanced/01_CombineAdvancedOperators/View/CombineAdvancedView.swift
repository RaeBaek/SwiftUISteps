//
//  CombineAdvancedView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/26/25.
//

import SwiftUI
import Combine

struct CombineAdvancedView: View {
    @StateObject private var viewModel = CombineAdvanceViewModel()
    @State private var cancellables = Set<AnyCancellable>()

    var body: some View {
        Form {
            Section("CombineLatest 예제") {
                TextField("Username", text: $viewModel.username)
                SecureField("Password", text: $viewModel.password)
                Text(viewModel.isValid ? "✅ 유효" : "❌ 비밀번호 6자 이상 필요")
            }

            Section("Merge + Throttle 예제") {
                Text("타이머: \(viewModel.timeString)")
            }

            Section("Retry + Catch 예제") {
                Button("데이터 가져오기") {
                    viewModel.fetchWithRetry()
                }
                Text(String(viewModel.user?.userId ?? 0))
                Text(String(viewModel.user?.id ?? 0))
                Text(viewModel.user?.title ?? "")
                Text(viewModel.user?.body ?? "")
            }
        }
    }
}

#Preview {
    CombineAdvancedView()
}
