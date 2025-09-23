//
//  AppState.swift
//  SwiftUIStepsTests
//
//  Created by 백래훈 on 9/23/25.
//

import SwiftUI

final class AppState: ObservableObject {
    @Published var navigationPath = NavigationPath()
    @Published var selectedEvent: Event?
    @Published var isLoggedIn = false
}
