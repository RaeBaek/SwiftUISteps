//
//  DogListView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/13/25.
//

import SwiftUI

struct DogListView: View {
    @StateObject private var viewModel: DogListViewModel

    init(container: DogDIContainer) {
        _viewModel = StateObject(wrappedValue: container.makeDogListViewModel())
    }

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 12) {
                        Text("⚠️ \(error)")
                            .foregroundStyle(.red)

                        Button("Retry") {
                            viewModel.load()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding(12)
                } else {
                    List(viewModel.dogs) { dog in
                        VStack(alignment: .leading) {
                            Text(dog.name)
                                .font(.headline)
                            Text(dog.description)
                                .foregroundStyle(.secondary)
                            Text("Life: \(dog.life)")
                            Text("Male Weight: \(dog.maleWeight)")
                            Text("Female Weight: \(dog.femaleWeight)")
                        }
                    }
                }
            }
            .navigationTitle("Clean Architecture")
            .task { viewModel.load() }
        }
    }
}
