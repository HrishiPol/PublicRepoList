//
//  RepoListAPI.swift
//  RepoList
//
//  Created by Hrishikesh Pol on 20/10/21.
//

import Moya
import Foundation
enum RepoListAPI {
    case getRepoList
    case getNextRepoList(request: String)
}
extension RepoListAPI: TargetType {
    var headers: [String : String]? {
        switch self {
        case .getRepoList, .getNextRepoList: fallthrough
        default:
            return [:]
        }
    }
    
    var baseURL: URL {
        switch self {
        case .getRepoList:
            return URL(string: .kBaseURL)!
        case .getNextRepoList(let request):
            return URL(string: request)!
        }
    }
    
    var path: String {
        switch self {
        case .getRepoList, .getNextRepoList:
            return ""
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getRepoList, .getNextRepoList:
            return .requestPlain
        }
    }
}
