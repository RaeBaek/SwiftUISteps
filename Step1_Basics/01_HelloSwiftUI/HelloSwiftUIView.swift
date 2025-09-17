//
//  HelloSwiftUIView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/17/25.
//

/*
 * SwiftUI의 선언형 UI 방식에 익숙해지기
 * UIKit에서의 imperative(명령형) 방식과의 차이점 체감
 * 상태에 따라 UI가 자동으로 갱신되는 구조 익히기
 */

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
