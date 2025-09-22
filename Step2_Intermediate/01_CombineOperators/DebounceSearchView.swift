//
//  DebounceSearchView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/22/25.
//

import SwiftUI

struct DebounceSearchView: View {
    @StateObject private var viewModel = SearchViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                TextField("검색어 입력", text: $viewModel.query)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                List(viewModel.results, id: \.self) { item in
                    Text(item)
                }
            }
            .navigationTitle("Debounce Search")
        }
    }
}

#Preview {
    DebounceSearchView()
}
