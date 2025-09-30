//
//  HomeView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/30/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var anAppState: ANAppState
    private let comments = [
        Comment(postId: 1, id: 1, name: "RaeHoon", email: "raehoon@naver.com", body: "Deep dive into navigation"),
        Comment(postId: 2, id: 2, name: "David", email: "david@kakao.co.kr", body: "Mixing async worlds")
    ]

    var body: some View {
        List(comments) { comment in
            Button {
                anAppState.homePath.append(comment) // push
            } label: {
                Text(comment.name)
            }
        }
        .toolbar {
            Button("딥링크: 두 번째 글") {
                if let second = comments.last {
                    anAppState.homePath.append(second)
                }
            }
        }
        .navigationTitle("Comments")
    }
}
