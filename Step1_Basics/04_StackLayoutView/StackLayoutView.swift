//
//  StackLayoutView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/19/25.
//

import SwiftUI

/*
 1. 수직·수평·겹침 배치
 - VStack: 세로 정렬
 - HStack: 가로 정렬
 - ZStack: 겹쳐 놓기

 2. 간격·정렬·크기 조절
 - spacing, alignment
 - padding, frame, Spacer

 3. UIKit AutoLayout과의 차이점
 - 제약 조건을 "설명"하는 대신 구조를 선언하는 방식의 이해
 */

struct StackLayoutView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("📚 SwiftUI Stack Layout")
                .font(.title)

            HStack(spacing: 16) {
                Color.red.frame(width: 60, height: 60)
                Color.green.frame(width: 60, height: 60)
                Color.blue.frame(width: 60, height: 60)
            }

            Text("아래 박스는 Spacer로 간격 조절")
                .font(.subheadline)

            HStack {
                Color.orange.frame(width: 40, height: 40)
                Spacer()
                Color.purple.frame(width: 40, height: 40)
            }
            .padding()
            .background(Color.gray.opacity(0.2))

            OverlapView()

            HStack(spacing: 17) {
                GeometryReaderView()
                GeometryReaderView()
            }
        }
        .padding()
    }
}

#Preview {
    StackLayoutView()
}
