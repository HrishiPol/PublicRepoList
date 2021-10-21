//
//  RepoListRepository.swift
//  RepoList
//
//  Created by Hrishikesh Pol on 20/10/21.
//

import Foundation
import ReactiveSwift
protocol RepoListRepository {
    func getRepoList() -> SignalProducer<RepoListResponse?, RepoListRepositoryError>
    func getNextRepoList(request: String) -> SignalProducer<RepoListResponse?, RepoListRepositoryError>
}

enum RepoListRepositoryError: Error {
    case unknownError
    case fetchError(reason: String = "Something went wrong please try again later.")
    case serviceError(reason: String = "Something went wrong please try again later.")
}
