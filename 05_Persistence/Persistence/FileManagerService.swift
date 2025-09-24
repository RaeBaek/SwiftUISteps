//
//  FileManagerService.swift
//  SwiftUIStepsTests
//
//  Created by 백래훈 on 9/24/25.
//

import Foundation

final class FileManagerService {
    private var fileURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("sample.txt")
    }

    func save(text: String) throws {
        try text.write(to: fileURL, atomically: true, encoding: .utf8)
    }

    func load() throws -> String {
        try String(contentsOf: fileURL, encoding: .utf8)
    }
}
