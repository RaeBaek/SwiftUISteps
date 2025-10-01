//
//  SwiftUIStepsApp.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/17/25.
//

import SwiftUI

@main
struct SwiftUIStepsApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            StaffListView(viewModel: StaffListViewModel(repository: RemoteStaffService()))
        }
    }
}
