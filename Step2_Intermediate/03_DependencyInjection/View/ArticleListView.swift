//
//  ArticleListView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/22/25.
//

import SwiftUI
import Combine

struct ArticleListView: View {
    @ObservedObject var viewModel: ArticleListViewModel

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundStyle(.red)
                } else {
                    List(viewModel.articles) { article in
                        VStack(alignment: .leading) {
                            Text(article.title)
                                .font(.headline)
                            Text(article.body)
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Articles")
            .task {
                viewModel.fetch()
            }
        }
    }
}

#Preview {
    let diContainer = DIContainer(articleService: ArticleService())
    ArticleListView(viewModel: diContainer.makeArticleListViewModel())
}
