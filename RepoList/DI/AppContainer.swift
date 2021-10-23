//
//  File.swift
//  RepoList
//
//  Created by Hrishikesh Pol on 21/10/21.
//

import Moya
import Swinject

/// Dependancy injection repo container.
let repoContainer = Container { container in
    container.register(RepoListRepository.self) { _ in
        if NSClassFromString("XCTest") != nil {
            let provider = MoyaProvider<MultiTarget>(stubClosure: MoyaProvider.delayedStub(0.2))
            return RepoListRepositoryImpl(provider: provider)
        } else {
            let provider = serviceContainer.resolve(MoyaProvider<MultiTarget>.self)
            return RepoListRepositoryImpl(provider: provider!)
        }
    }.inObjectScope(.container)
    container.register(GetRepoListUseCase.self) { resolver in
        let repo = resolver.resolve(RepoListRepository.self)!
        let useCase = GetRepoListUseCase(repoListRepository: repo)
        return useCase
    }
    container.register(RepoListViewModel.self) { resolver in
        let useCase = resolver.resolve(GetRepoListUseCase.self)!
        return  RepoListViewModel(repoListUseCase: useCase)
    }
}

/// Dependancy injection service container
let serviceContainer = Container { container in
    container.register(MoyaProvider<MultiTarget>.self) { _ in
        MoyaProvider<MultiTarget>()
    }.inObjectScope(.container)
}
