//
//  StaffRepository.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/1/25.
//

import Combine

protocol StaffRepository {
    func fetchStaffs() -> AnyPublisher<[Staff], Error>
}
