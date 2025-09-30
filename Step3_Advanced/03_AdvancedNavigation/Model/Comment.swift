//
//  Comment.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/30/25.
//

import Foundation

struct Comment: Hashable, Identifiable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
