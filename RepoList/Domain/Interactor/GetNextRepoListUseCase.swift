//
//  GetNextRepoListUseCase.swift
//  RepoList
//
//  Created by Hrishikesh Pol on 21/10/21.
//

import Foundation
import ReactiveSwift

/// Load next repo list use case.
class GetNextRepoListUseCase: UseCaseWithParameter {
    
    /// Output as signal from response.
    typealias Output = SignalProducer<Loadable<RepoListResponse?>, Never>
    
    /// Input next repo list url.
    typealias Input = String
    let repoListRepo: RepoListRepository
    
    /// Init use case with repository as dependancy injection.
    /// - Parameter repoListRepository: <#repoListRepository description#>
    init(repoListRepository: RepoListRepository) {
        self.repoListRepo = repoListRepository
    }
    
    /// Execute the use case.
    /// - Parameter input: Next repo list url string.
    /// - Returns: Return RepoListResponse object on success and error if any.
    func execute(input: Input) -> SignalProducer<Loadable<RepoListResponse?>, Never> {
        return repoListRepo.getRepoList()
            .map { response in Loadable.success(data: response)}
            .flatMapError { (error: Error) -> SignalProducer<Loadable<RepoListResponse?>, Never> in
                SignalProducer(value: Loadable.error(error: error)) }
            .prefix(value: Loadable.loading)
    }
}
