//
//  GeometryReaderView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/19/25.
//

import SwiftUI

/*
 - 부모 View의 사이즈가 변할 때마다 geometry 값이 업데이트
 - iPad, iPhone, 가로/세로 전환에 대응하는 반응형 UI 제작 시 유용
 */

struct GeometryReaderView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Width: \(String(format: "%.2f", Double(geometry.size.width)))")
                Text("Height: \(String(format: "%.2f", Double(geometry.size.height)))")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.blue.opacity(0.2))
        }
    }
}

#Preview {
    GeometryReaderView()
}
