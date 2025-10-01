//
//  StaffListView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/1/25.
//

import SwiftUI
import Combine

struct StaffListView: View {
    @ObservedObject var viewModel: StaffListViewModel
    @State private var showError = false

    var body: some View {
        VStack {
            Button("Fetch Staffs") {
                viewModel.fetch()
            }

            List(viewModel.staffs) { staff in
                Text(staff.name)
            }
        }
        // Alert 바인딩
        .alert("에러 발생", isPresented: $showError) {
            Button("OK", role: .cancel) {
                viewModel.errorMessage = nil
                showError = false
            }
        } message: {
            Text(viewModel.errorMessage ?? "알 수 없는 오류")
        }
        // errorMessage 변화를 감지해서 showError를 true로 변경
        .onChange(of: viewModel.errorMessage) { _, newValue in
            if newValue != nil {
                showError = true
            }
        }
    }
}
