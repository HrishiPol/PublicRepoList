//
//  RepoListRepositoryImpl.swift
//  RepoList
//
//  Created by Hrishikesh Pol on 20/10/21.
//
import Moya
import Foundation
import ReactiveSwift

/// Repository implementation class.
class RepoListRepositoryImpl: RepoListRepository {
    
    /// Represents the moya provider.
    let provider: MoyaProvider<MultiTarget>
    
    /// Inject moya provider.
    /// - Parameter provider: <#provider description#>
    init(provider: MoyaProvider<MultiTarget>) {
        self.provider = provider
    }
    
    /// Fetch list of public repositories.
    /// - Returns: Return RepoListResponse object on success and RepoListRepositoryError on failure.
    func getRepoList() -> SignalProducer<RepoListResponse?, RepoListRepositoryError> {
        return provider
            .reactive
            .request(MultiTarget(RepoListAPI.getRepoList))
            .mapError { error -> RepoListRepositoryError in RepoListRepositoryError.serviceError(reason: error.errorDescription ?? "")}
            .attemptMap { response -> Result<RepoListResponse?, RepoListRepositoryError> in
                do {
                    let errorData = try? response
                        .map(ErrorResponse.self)
                        .error
                    if let errorCode = errorData?.errorCode {
                        if errorCode == "401" {
                            throw RepoListRepositoryError.fetchError(reason: errorData?.errorDescription ?? "")
                        } else {
                            throw RepoListRepositoryError.serviceError(reason: errorData?.errorDescription ?? "")
                        }
                    }
                    do {
                        let responseData = try? response
                            .map(RepoListResponse.self)
                        guard let data = responseData else {
                            return .failure(RepoListRepositoryError.serviceError(reason: .kGenericError))
                        }
                        return .success(data)
                    }
                } catch let error {
                    if let error = error as? RepoListRepositoryError {
                        switch error {
                        case let .serviceError(reason):
                            return .failure(RepoListRepositoryError.serviceError(reason: reason))
                        default:
                            return .failure(RepoListRepositoryError.serviceError(reason: error.localizedDescription))
                        }
                    }
                    return .failure(RepoListRepositoryError.serviceError(reason: error.localizedDescription))
                }
        }
    }
    
    /// Fetch list of public repositories from next load.
    /// - Returns: Return RepoListResponse object on success and RepoListRepositoryError on failure.
    func getNextRepoList(request: String) -> SignalProducer<RepoListResponse?, RepoListRepositoryError> {
        return provider
            .reactive
            .request(MultiTarget(RepoListAPI.getNextRepoList(request: request)))
            .mapError { error -> RepoListRepositoryError in RepoListRepositoryError.serviceError(reason: error.errorDescription ?? "")}
            .attemptMap { response -> Result<RepoListResponse?, RepoListRepositoryError> in
                do {
                    let errorData = try? response
                        .map(ErrorResponse.self)
                        .error
                    if let errorCode = errorData?.errorCode {
                        if errorCode == "401" {
                            throw RepoListRepositoryError.fetchError(reason: errorData?.errorDescription ?? "")
                        } else {
                            throw RepoListRepositoryError.serviceError(reason: errorData?.errorDescription ?? "")
                        }
                    }
                    do {
                        let responseData = try? response
                            .map(RepoListResponse.self)
                        guard let data = responseData else {
                            return .failure(RepoListRepositoryError.serviceError(reason: .kGenericError))
                        }
                        return .success(data)
                    }
                } catch let error {
                    if let error = error as? RepoListRepositoryError {
                        switch error {
                        case let .serviceError(reason):
                            return .failure(RepoListRepositoryError.serviceError(reason: reason))
                        default:
                            return .failure(RepoListRepositoryError.serviceError(reason: error.localizedDescription))
                        }
                    }
                    return .failure(RepoListRepositoryError.serviceError(reason: error.localizedDescription))
                }
        }
    }
}
