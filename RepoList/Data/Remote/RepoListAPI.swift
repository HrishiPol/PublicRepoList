//
//  RepoListAPI.swift
//  RepoList
//
//  Created by Hrishikesh Pol on 20/10/21.
//

import Moya
import Foundation

/// Enum describes the api list.
enum RepoListAPI {
    case getRepoList
    case getNextRepoList(request: String)
}
/**
 This target is for all endpoints.
 */
extension RepoListAPI: TargetType {
    /// Represents the headers pass to the each api.
    var headers: [String : String]? {
        switch self {
        case .getRepoList, .getNextRepoList: fallthrough
        default:
            return [:]
        }
    }
    
    /// Describe baseURL for each api.
    var baseURL: URL {
        switch self {
        case .getRepoList:
            return URL(string: .kBaseURL)!
        case .getNextRepoList(let request):
            return URL(string: request)!
        }
    }
    
    /// Describe path for each api.
    var path: String {
        switch self {
        case .getRepoList, .getNextRepoList:
            return ""
        }
    }
    
    /// Describe http method type for each api.
    var method: Moya.Method {
        return .get
    }
    
    /// Describe sample data for each api.
    var sampleData: Data {
        guard let url = Bundle.main.url(forResource: "SampleResponse", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return Data()
        }
        return data
    }
    
    /// Describe taskl for each api.
    var task: Task {
        switch self {
        case .getRepoList, .getNextRepoList:
            return .requestPlain
        }
    }
}
