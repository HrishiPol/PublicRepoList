//
//  RepoListResponse.swift
//  RepoList
//
//  Created by Hrishikesh Pol on 20/10/21.
//

import Foundation

// MARK: - RepoListResponse
struct RepoListResponse: Codable {
    let pagelen: Int?
    let values: [Value]?
    let next: String?
}

// MARK: - Value
struct Value: Codable {
    let scm: SCM?
    let website: String?
    let hasWiki: Bool?
    let uuid: String?
    let links: ValueLinks?
    let forkPolicy: ForkPolicy?
    let fullName, name: String?
    let project: Project?
    let language, createdOn: String?
    let mainbranch: Mainbranch?
    let workspace: Project?
    let hasIssues: Bool?
    let owner: Owner?
    let updatedOn: String?
    let size: Int?
    let type: ValueType?
    let slug: String?
    let isPrivate: Bool?
    let valueDescription: String?

    enum CodingKeys: String, CodingKey {
        case scm, website
        case hasWiki = "has_wiki"
        case uuid, links
        case forkPolicy = "fork_policy"
        case fullName = "full_name"
        case name, project, language
        case createdOn = "created_on"
        case mainbranch, workspace
        case hasIssues = "has_issues"
        case owner
        case updatedOn = "updated_on"
        case size, type, slug
        case isPrivate = "is_private"
        case valueDescription = "description"
    }
}

// MARK: - ForkPolicy
enum ForkPolicy: String, Codable {
    case allowForks = "allow_forks"
}

// MARK: - ValueLinks
struct ValueLinks: Codable {
    let watchers, branches, tags, commits: Avatar?
    let clone: [Clone]?
    let linksSelf, source, html, avatar: Avatar?
    let hooks, forks, downloads, pullrequests: Avatar?
    let issues: Avatar?

    enum CodingKeys: String, CodingKey {
        case watchers, branches, tags, commits, clone
        case linksSelf = "self"
        case source, html, avatar, hooks, forks, downloads, pullrequests, issues
    }
}

// MARK: - Avatar
struct Avatar: Codable {
    let href: String?
}

// MARK: - Clone
struct Clone: Codable {
    let href: String?
    let name: CloneName?
}

// MARK: - CloneName
enum CloneName: String, Codable {
    case https = "https"
    case ssh = "ssh"
}

// MARK: - Mainbranch
struct Mainbranch: Codable {
    let type: MainbranchType?
    let name: MainbranchName?
}

// MARK: - MainbranchName
enum MainbranchName: String, Codable {
    case master = "master"
}

// MARK: - MainbranchType
enum MainbranchType: String, Codable {
    case branch = "branch"
}

// MARK: - Owner
struct Owner: Codable {
    let displayName, uuid: String?
    let links: OwnerLinks?
    let type: OwnerType?
    let nickname: String?
    let accountID: String?
    let username: String?

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case uuid, links, type, nickname
        case accountID = "account_id"
        case username
    }
}

// MARK: - OwnerLinks
struct OwnerLinks: Codable {
    let linksSelf, html, avatar: Avatar?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, avatar
    }
}

// MARK: - OwnerType
enum OwnerType: String, Codable {
    case team = "team"
    case user = "user"
}

// MARK: - Project
struct Project: Codable {
    let links: OwnerLinks?
    let type: ProjectType?
    let name: String?
    let key: Key?
    let uuid, slug: String?
}

// MARK: - Key
enum Key: String, Codable {
    case proj = "PROJ"
}

// MARK: - ProjectType
enum ProjectType: String, Codable {
    case project = "project"
    case workspace = "workspace"
}

// MARK: - SCM
enum SCM: String, Codable {
    case git = "git"
}

// MARK: - ValueType
enum ValueType: String, Codable {
    case repository = "repository"
}
