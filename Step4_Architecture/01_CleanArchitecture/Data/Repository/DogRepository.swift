//
//  DogRepository.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/13/25.
//

import Combine

protocol DogRepository {
    func fetchDogs() -> AnyPublisher<[Dog], Error>
}
