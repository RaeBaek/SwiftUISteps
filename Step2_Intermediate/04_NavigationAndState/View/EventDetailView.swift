//
//  EventDetailView.swift
//  SwiftUIStepsTests
//
//  Created by 백래훈 on 9/23/25.
//

import SwiftUI

struct EventDetailView: View {
    @EnvironmentObject var appState: AppState
    let event: Event

    var body: some View {
        VStack(spacing: 16) {
            Text(event.title)
                .font(.largeTitle)
            Text(event.body)

            Button("Pop to Root") {
                appState.navigationPath.removeLast(appState.navigationPath.count)
            }
        }
        .padding()
        .navigationTitle("Detail")
    }
}
