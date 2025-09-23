//
//  EventListView.swift
//  SwiftUIStepsTests
//
//  Created by 백래훈 on 9/23/25.
//

import SwiftUI

struct EventListView: View {
    @EnvironmentObject var appState: AppState
    private let events: [Event] = [
        .init(id: 1, title: "SwiftUI", body: "NavigationPath demo"),
        .init(id: 2, title: "Combine", body: "Advanced state management")
    ]

    var body: some View {
        List(events) { event in
            Button {
                appState.navigationPath.append(event) // 타입 세이프 push
            } label: {
                VStack(alignment: .leading) {
                    Text(event.title).font(.headline)
                    Text(event.body).font(.subheadline)
                }
            }
        }
        .toolbar {
            Button("Go Setting") {
                appState.navigationPath.append("Settings")
            }
        }
        .navigationTitle("Events")
    }
}

#Preview {
    EventListView()
}
