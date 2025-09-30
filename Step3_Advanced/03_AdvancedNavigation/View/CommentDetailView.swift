//
//  CommentDetailView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/30/25.
//

import SwiftUI

struct CommentDetailView: View {
    @EnvironmentObject var anAppState: ANAppState
    let comment: Comment

    var body: some View {
        VStack(spacing: 16) {
            Text(comment.name).font(.largeTitle)
            Text(comment.email).font(.title)
            Text(comment.body).font(.title2)

            Button("Pop to Root") {
                anAppState.homePath.removeLast(anAppState.homePath.count)
            }
        }
        .padding()
        .navigationTitle("Comment Detail")
    }
}
