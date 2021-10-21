//
//  RepoListRepositoryImpl.swift
//  RepoList
//
//  Created by Hrishikesh Pol on 20/10/21.
//
import Moya
import Foundation
import ReactiveSwift

class RepoListRepositoryImpl: RepoListRepository {
            
    let provider: MoyaProvider<MultiTarget>
    
    init(provider: MoyaProvider<MultiTarget>) {
        self.provider = provider
    }
    
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
