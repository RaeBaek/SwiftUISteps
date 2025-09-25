//
//  FileManagerExampleView.swift
//  SwiftUIStepsTests
//
//  Created by 백래훈 on 9/24/25.
//

import SwiftUI

struct FileManagerExampleView: View {
    @State private var content = ""
    private let service = FileManagerService()

    var body: some View {
        VStack {
            TextEditor(text: $content)
                .border(.gray)
                .padding(.vertical)
            HStack {
                Button("저장") {
                    try? service.save(text: content)
                }
                .buttonStyle(.borderedProminent)
                .clipShape(.capsule)
                .tint(.primary)

                Button("불러오기") {
                    content = (try? service.load()) ?? ""
                }
                .buttonStyle(.borderedProminent)
                .clipShape(.capsule)
                .tint(.primary)
            }
        }
        .padding()
    }
}

#Preview {
    FileManagerExampleView()
}
