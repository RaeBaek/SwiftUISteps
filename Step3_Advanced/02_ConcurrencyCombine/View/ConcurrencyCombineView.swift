//
//  View.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/29/25.
//

import SwiftUI
import Combine

struct ConcurrencyCombineView: View {
    @StateObject private var viewModel = ConcurrencyCombineViewModel()
    @State private var cancellables = Set<AnyCancellable>()

    var body: some View {
        VStack(spacing: 16) {
            Button("Start Timer (AsyncPublisher)") {
                viewModel.startTimerAsync()
            }

            Button("Fetch Data (Future)") {
                viewModel.fetchData()
                    .sink { value in
                        viewModel.outputLog.append(value)
                    }
                    .store(in: &cancellables)
            }

            List(viewModel.outputLog, id: \.self) { Text($0) }
        }
    }
}

#Preview {
    ConcurrencyCombineView()
}
