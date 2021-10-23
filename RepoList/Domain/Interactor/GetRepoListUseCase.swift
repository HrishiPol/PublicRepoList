//
//  GetRepoListUseCase.swift
//  RepoList
//
//  Created by Hrishikesh Pol on 20/10/21.
//

import Foundation
import ReactiveSwift

/// Use case to load repo list.
class GetRepoListUseCase: UseCase {
    
    /// Output as signal from response.
    typealias Output = SignalProducer<Loadable<RepoListResponse?>, Never>
    /// Repository instance
    let repoListRepo: RepoListRepository
    
    /// Init use case and inject repository.
    /// - Parameter repoListRepository: <#repoListRepository description#>
    init(repoListRepository: RepoListRepository) {
        self.repoListRepo = repoListRepository
    }
    
    /// Execute the use case function.
    /// - Returns: Return RepoListResponse object on success and  error if any.
    func execute() -> SignalProducer<Loadable<RepoListResponse?>, Never> {
        return repoListRepo.getRepoList()
            .map { response in Loadable.success(data: response)}
            .flatMapError { (error: Error) -> SignalProducer<Loadable<RepoListResponse?>, Never> in
                SignalProducer(value: Loadable.error(error: error)) }
            .prefix(value: Loadable.loading)
    }
}
