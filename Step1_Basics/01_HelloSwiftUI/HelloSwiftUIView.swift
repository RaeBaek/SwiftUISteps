//
//  HelloSwiftUIView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/17/25.
//

import SwiftUI

struct HelloSwiftUIView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Hello, SwiftUI!")
                .font(.largeTitle)
                .foregroundStyle(.blue)

            Button("눌러보세요") {
                print("버튼이 눌렸습니다!")
            }
        }
        .padding()
    }
}

#Preview {
    HelloSwiftUIView()
}
