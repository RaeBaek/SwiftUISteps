//
//  StateAndBindingView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/17/25.
//

/*
 * @State로 로컬 상태 관리
 * @Binding으로 자식 뷰와 상태 연결
 * View가 상태 변화에 따라 자동으로 업데이트됨을 체감

 - @State: 로컬 뷰에서 상태를 소유하고 관리할 때 사용
 - @Binding: 부모 뷰에서 전달받은 상태를 읽고/쓸 수 있음 (상호작용)
 */

import SwiftUI

struct StateAndBindingView: View {
    @State private var isOn: Bool = false

    var body: some View {
        VStack(spacing: 30) {
            Text(isOn ? "스위치 ON" : "스위치 OFF")
                .font(.title)

            Toggle("스위치를 켜보세요", isOn: $isOn)
                .padding()

            ChildSwitchView(isOn: $isOn)
        }
        .padding()
    }
}

#Preview {
    StateAndBindingView()
}
