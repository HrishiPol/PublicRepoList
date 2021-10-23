//
//  ErrorResponse.swift
//  RepoList
//
//  Created by Hrishikesh Pol on 20/10/21.
//

import Foundation
// Error response structure.
struct ErrorResponse: Codable {
   let error: ErrorValue
}
struct ErrorValue: Codable {
    let errorCode, errorDescription: String
}
