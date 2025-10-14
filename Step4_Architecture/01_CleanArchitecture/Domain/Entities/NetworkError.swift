//
//  NetworkError.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/14/25.
//

import Foundation

/// 커스텀 에러 정의
enum NetworkError: Error, LocalizedError {
    case network(URLError)          // 통신/연결 문제
    case decoding(DecodingError)    // JSON 디코딩 문제
    case unknown(Error)             // 기타

    var errorDescription: String? {
        switch self {
        case .network(let e):
            return "Network error: \(e.localizedDescription)"
        case .decoding(let e):
            return "Decoding error: \(e.localizedDescription)"
        case .unknown(let e):
            return "Unknown error: \(e.localizedDescription)"
        }
    }
}
