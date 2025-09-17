//
//  StateAndBindingView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/17/25.
//

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
