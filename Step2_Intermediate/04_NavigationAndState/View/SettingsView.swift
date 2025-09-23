//
//  SettingView.swift
//  SwiftUIStepsTests
//
//  Created by 백래훈 on 9/23/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 20) {
            Text("⚙️ Settings")
                .font(.largeTitle)
                .padding(.bottom, 20)

            Toggle("로그인 상태", isOn: $appState.isLoggedIn)
                .padding()

            Button("루트로 돌아가기") {
                // NavigationPath 비우기 → RootView로 pop
                appState.navigationPath.removeLast(appState.navigationPath.count)
            }
            .padding()
        }
        .navigationTitle("Settings")
        .padding()
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppState())
}
