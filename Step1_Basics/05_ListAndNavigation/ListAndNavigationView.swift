//
//  ListAndNavigationView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/19/25.
//

import SwiftUI

/*
 - List와 ForEach로 동적·정적 목록 만들기
 - NavigationStack + NavigationLink를 사용한 화면 전환
 - 데이터 바인딩과 삭제/추가 동작 이해

 - NavigationStack: iOS16+ 권장 (기존 NavigationView의 개선판)
 - NavigationLink: 터치 시 다음 화면으로 이동
 */

struct ListAndNavigationView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("프로필 보기") {
                    Text("프로필 화면")
                        .font(.largeTitle)
                }
                NavigationLink("설정") {
                    Text("설정 화면")
                        .font(.largeTitle)
                }
            }
            .navigationTitle("메인 메뉴")
        }
    }
}

#Preview {
    ListAndNavigationView()
}
