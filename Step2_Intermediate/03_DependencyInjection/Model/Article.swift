//
//  Article.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/22/25.
//

import Foundation

struct Article: Identifiable, Codable {
    let id: Int
    let title: String
    let body: String
}
