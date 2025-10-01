//
//  MockStaffRepository.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/1/25.
//

import Combine

final class MockStaffRepository: StaffRepository {
    func fetchStaffs() -> AnyPublisher<[Staff], Error> {
        return Just([
            Staff(id: 0,
                  name: "RaeHoon",
                  username: "Baek",
                  email: "bmp117@naver.com",
                  address: Address(street: "", suite: "", city: "", zipcode: "", geo: Geo(lat: "", lng: "")),
                  phone: "",
                  website: "",
                  company: Company(name: "", catchPhrase: "", bs: ""))
        ])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}
