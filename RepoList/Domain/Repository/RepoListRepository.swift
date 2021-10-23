//
//  RepoListRepository.swift
//  RepoList
//
//  Created by Hrishikesh Pol on 20/10/21.
//

import Foundation
import ReactiveSwift

/// Protocol describe all end points.
protocol RepoListRepository {
    func getRepoList() -> SignalProducer<RepoListResponse?, RepoListRepositoryError>
    func getNextRepoList(request: String) -> SignalProducer<RepoListResponse?, RepoListRepositoryError>
}

/// Enum describes the type error for the RepoListRepository protocol.
enum RepoListRepositoryError: Error {
    case unknownError
    case fetchError(reason: String = "Something went wrong please try again later.")
    case serviceError(reason: String = "Something went wrong please try again later.")
}
