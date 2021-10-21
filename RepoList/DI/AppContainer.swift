//
//  File.swift
//  RepoList
//
//  Created by Hrishikesh Pol on 21/10/21.
//

import Moya
import Swinject

let repoContainer = Container { container in
    container.register(RepoListRepository.self) { _ in
        let provider = serviceContainer.resolve(MoyaProvider<MultiTarget>.self)
        return RepoListRepositoryImpl(provider: provider!)
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

let serviceContainer = Container { container in
    container.register(MoyaProvider<MultiTarget>.self) { _ in
        MoyaProvider<MultiTarget>()
    }.inObjectScope(.container)
}
