//
//  GetNextRepoListUseCase.swift
//  RepoList
//
//  Created by Hrishikesh Pol on 21/10/21.
//

import Foundation
import ReactiveSwift

class GetNextRepoListUseCase: UseCaseWithParameter {
    
    /// Output as signal from response.
    typealias Output = SignalProducer<Loadable<RepoListResponse?>, Never>
    typealias Input = String
    let repoListRepo: RepoListRepository
    
    init(repoListRepository: RepoListRepository) {
        self.repoListRepo = repoListRepository
    }
    
    func execute(input: Input) -> SignalProducer<Loadable<RepoListResponse?>, Never> {
        return repoListRepo.getRepoList()
            .map { response in Loadable.success(data: response)}
            .flatMapError { (error: Error) -> SignalProducer<Loadable<RepoListResponse?>, Never> in
                SignalProducer(value: Loadable.error(error: error)) }
            .prefix(value: Loadable.loading)
    }
}
