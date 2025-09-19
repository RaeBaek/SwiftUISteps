//
//  LazyVStackView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/19/25.
//

import SwiftUI

struct LazyVStackView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12, pinnedViews: [.sectionHeaders]) {
                Section(header: Text("헤더")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(8)
                    .background(Color.yellow)
                ) {
                    ForEach(0..<100, id: \.self) { index in
                        Text("아이템: \(index)")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
        }
    }
}

#Preview {
    LazyVStackView()
}
