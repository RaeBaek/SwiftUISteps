//
//  UserDefaultsExampleView.swift
//  SwiftUIStepsTests
//
//  Created by 백래훈 on 9/24/25.
//

import SwiftUI

struct UserDefaultsExampleView: View {
    @State private var favorites: [String] = []
    @State private var input: String = ""
    private let manager = UserDefaultsManager()

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("추가할 항목", text: $input)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button("저장") {
                        favorites.append(input)
                        manager.saveFavorites(favorites)
                        input = ""
                    }
                    .buttonStyle(.borderedProminent)
                    .clipShape(.capsule)
                    .tint(.primary)
                }

                List(favorites, id: \.self) { Text($0) }
            }
            .navigationTitle("UserDefaults")
            .onAppear {
                favorites = manager.loadFavorites()
            }
            .padding()
        }
    }
}

#Preview {
    UserDefaultsExampleView()
}
