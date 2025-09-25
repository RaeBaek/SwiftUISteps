//
//  CoreDataExampleView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/25/25.
//

import SwiftUI

struct CoreDataExampleView: View {
    @StateObject private var viewModel = CoreDataViewModel()
    @State private var input = ""

    var body: some View {
        VStack {
            TextField("제목 입력", text: $input)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("추가") {
                viewModel.add(title: input)
                input = ""
            }
            List {
                ForEach(viewModel.items) { item in
                    Text(item.title ?? "")
                        .swipeActions {
                            Button(role: .destructive) {
                                viewModel.delete(item)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fetch()
        }
    }
}

#Preview {
    CoreDataExampleView()
}
