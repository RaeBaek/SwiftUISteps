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

    private let localDogRepository = LocalDogRepository()
    private lazy var remoteDogRepository = RemoteDogRepository(api: dogAPI)
    private lazy var combineRepository = CombinedDogRepository(
        remote: remoteDogRepository,
        local: localDogRepository
    )

    // UseCases
    lazy var fetchDogUseCase: FetchDogsUseCase = FetchDogsUseCaseImpl(repository: combineRepository)

    // Factory (ViewModel)
    func makeDogListViewModel() -> DogListViewModel {
        DogListViewModel(fetchDogs: fetchDogUseCase)
    }

}
