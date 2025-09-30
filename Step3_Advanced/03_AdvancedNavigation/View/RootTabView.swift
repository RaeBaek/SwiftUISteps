//
//  RootTabView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/30/25.
//

/*
 1. NavigationStack + NavigationPath 고급
    - 딥링크 시뮬레이션 (path.append로 특정 화면 바로 열기)
    - pop to root / 특정 깊이 pop
 2. TabView + 독립 NavigationPath
    - 각 탭(Home, Profile, ANSettings)이 독립적인 NavigationStack을 가짐
 3. 전역 상태 관리
    - ANAppState를 @EnvironmentObject로 주입 -> 전체 네비게이션 상태 공유 가능
 */

import SwiftUI

struct RootTabView: View {
    @StateObject private var anAppState = ANAppState()

    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                NavigationStack(path: $anAppState.homePath) {
                    HomeView()
                        .navigationDestination(for: Comment.self) { comment in
                            CommentDetailView(comment: comment)
                        }
                }
            }

            Tab("Profile", systemImage: "person") {
                NavigationStack(path: $anAppState.profilePath) {
                    ProfileView()
                }
            }

            Tab("Settings", systemImage: "gear") {
                NavigationStack(path: $anAppState.settingsPath) {
                    ANSettingsView()
                }
            }
        }
        .environmentObject(anAppState)
    }
}

#Preview {
    RootTabView()
}
