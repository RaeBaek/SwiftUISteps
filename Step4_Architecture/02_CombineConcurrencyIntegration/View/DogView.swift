//
//  DogView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/14/25.
//

import SwiftUI

struct DogView: View {
    @StateObject private var viewModel = DogViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text("⚠️ \(error)")
                    }
                    .padding(12)
                } else {
                    List(viewModel.dogs) { dog in
                        VStack(alignment: .leading) {
                            Text(dog.name).font(.headline)
                            Text(dog.description).foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Dogs 🐶")
            .task { viewModel.fetchDogs() }
        }
    }
}
