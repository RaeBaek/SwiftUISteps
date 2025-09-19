//
//  OverlapView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/19/25.
//

import SwiftUI

struct OverlapView: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(height: 200)

            Text("Overlay Text")
                .padding(8)
                .background(Color.black.opacity(0.6))
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .padding()
        }
    }
}

#Preview {
    OverlapView()
}
