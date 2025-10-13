//
//  DogDIContainer.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 10/13/25.
//

import Foundation

final class DogDIContainer {
    // Data Layer
    private let dogAPI = DogAPI()
    private lazy var dogRepository: DogRepository = DogRepositoryImpl(api: dogAPI)

    // UseCases
    lazy var fetchDogUseCase: FetchDogsUseCase = FetchDogsUseCaseImpl(repository: dogRepository)

    // Factory (ViewModel)
    func makeDogListViewModel() -> DogListViewModel {
        DogListViewModel(fetchDogs: fetchDogUseCase)
    }

}
