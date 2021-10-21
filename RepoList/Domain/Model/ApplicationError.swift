//
//  ApplicationError.swift
//  RepoList
//
//  Created by Hrishikesh Pol on 20/10/21.
//

import Foundation
enum ApplicationError: Error {
    case unknownError
    case serviceError(message: String)
}
