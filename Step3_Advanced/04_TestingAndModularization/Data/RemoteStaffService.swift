//
//  RemoteStaffService.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/1/25.
//

import Foundation
import Combine

final class RemoteStaffService: StaffRepository {
    func fetchStaffs() -> AnyPublisher<[Staff], Error> {
        Future { promise in
            Task {
                do {
                    let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let staffs = try JSONDecoder().decode([Staff].self, from: data)
                    promise(.success(staffs))
                } catch let error {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
