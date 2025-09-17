//
//  ChildSwitchView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/17/25.
//

import SwiftUI

struct ChildSwitchView: View {
    @Binding var isOn: Bool

    var body: some View {
        Button(action: {
            isOn.toggle()
        }) {
            Text("자식 뷰에서 상태 변경")
                .padding()
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}
