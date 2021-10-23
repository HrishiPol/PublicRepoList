//
//  Loadable.swift
//  RepoList
//
//  Created by Hrishikesh Pol on 20/10/21.
//

import Foundation
// Loadable enum.
enum Loadable<T> {
    case success(data: T)
    case error(error: Error)
    case loading
}

