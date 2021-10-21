//
//  GetRepoListUseCase.swift
//  RepoList
//
//  Created by Hrishikesh Pol on 20/10/21.
//

import Foundation
import ReactiveSwift

class GetRepoListUseCase: UseCase {
    
    /// Output as signal from response.
    typealias Output = SignalProducer<Loadable<RepoListResponse?>, Never>
    let repoListRepo: RepoListRepository
    
    init(repoListRepository: RepoListRepository) {
        self.repoListRepo = repoListRepository
    }
    
    func execute() -> SignalProducer<Loadable<RepoListResponse?>, Never> {
        return repoListRepo.getRepoList()
            .map { response in Loadable.success(data: response)}
            .flatMapError { (error: Error) -> SignalProducer<Loadable<RepoListResponse?>, Never> in
                SignalProducer(value: Loadable.error(error: error)) }
            .prefix(value: Loadable.loading)
    }
}
