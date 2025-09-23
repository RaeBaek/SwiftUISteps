//
//  RootView.swift
//  SwiftUIStepsTests
//
//  Created by 백래훈 on 9/23/25.
//

import SwiftUI

/*
 - NavigationStack + NavigationPath
    - iOS16+의 타입 세이프한 화면 스택 제어
    - 동적 push/pop, 딥링크 처리
 - 전역 상태 관리
    - @EnvironmentObject를 통한 App 전역 공유
    - Scene/앱 레벨의 데이터 변경을 모든 View가 구독

 - NavigationPath: [AnyHashable] 기반으로 push/pop 경로를 동적으로 관리
 - @EnvironmentObject: 앱 전역에서 하나의 상태(AppState)를 모든 뷰가 공유
 - 프로그래매틱 네비게이션: 버튼/이벤트로 원하는 타입을 append, removeLast
 */

struct RootView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationStack(path: $appState.navigationPath) {
            EventListView()
                .navigationDestination(for: Event.self) { event in
                    EventDetailView(event: event)
                }
                .navigationDestination(for: String.self) { route in
                    if route == "Settings" {
                        SettingsView()
                    }
                }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(AppState())
}
