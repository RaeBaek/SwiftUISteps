//
//  ANAppState.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/30/25.
//

import SwiftUI

final class ANAppState: ObservableObject {
    @Published var homePath = NavigationPath()
    @Published var profilePath = NavigationPath()
    @Published var settingsPath = NavigationPath()
}
