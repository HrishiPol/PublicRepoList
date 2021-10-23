//
//  UseCase.swift
//  RepoList
//
//  Created by Hrishikesh Pol on 20/10/21.
//

import Foundation

// Protocols which defines the use case and its types.
protocol UseCase {
    associatedtype Output
    func execute() -> Output
}

protocol CompletableUseCase {
    func execute()
}

protocol CompletableUseCaseWithParameter {
    associatedtype Input
    func execute(input: Input)
}

protocol UseCaseWithParameter {
    associatedtype Input
    associatedtype Output
    func execute(input: Input) -> Output
}
