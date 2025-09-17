//
//  ObservableObjectView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/17/25.
//

/*
 - ObservableObject: 상태 변화를 외부로 알릴 수 있는 ViewModel 클래스
 - @Published: 속성 변경 시 UI 갱신을 트리거하는 변수
 - @ObservedObject: 외부 ViewModel을 관찰하는 뷰에서 사용
 - @StateObject: View에서 ViewModel을 직접 생성하고 소유할 때 사용 (처음 한 번만 초기화)

 * @Published - ViewModel 내부 - 값이 바뀔 때 UI에게 알림
 * @StateObject - View 내부에서 ViewModel 생성 시 - View가 ViewModel을 직접 소유
 * @ObservedObject - ViewModel을 외부에서 주입받을 때 - 다른 View에서 생성된 ViewModel을 관찰
 */

import SwiftUI

struct ObservableObjectView: View {
    @StateObject private var viewModel = CounterViewModel() // View가 소유

    var body: some View {
        VStack(spacing: 20) {
            Text("카운트: \(viewModel.count)")
                .font(.largeTitle)

            HStack(spacing: 40) {
                Button("-") {
                    viewModel.decrement()
                }
                .font(.largeTitle)

                Button("+") {
                    viewModel.increment()
                }
                .font(.largeTitle)
            }
        }
        .padding()
    }
}

#Preview {
    ObservableObjectView()
}
