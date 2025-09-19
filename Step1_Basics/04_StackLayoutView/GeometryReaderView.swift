//
//  GeometryReaderView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/19/25.
//

import SwiftUI

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
