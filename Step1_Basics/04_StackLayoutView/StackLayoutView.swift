//
//  StackLayoutView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/19/25.
//

import SwiftUI

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
