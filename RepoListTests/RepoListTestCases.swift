//
//  RepoListTestCases.swift
//  RepoListTests
//
//  Created by Hrishikesh Pol on 22/10/21.
//

import Moya
import Quick
import Nimble
import ReactiveSwift
@testable import RepoList
private struct Expected {
    static let next = "https://api.bitbucket.org/2.0/repositories?after=2011-09-03T12%3A33%3A16.028393%2B00%3A00"
    static let pageLength = 10
}
class RepoListTestCases: QuickSpec {
    override func spec() {
        
        describe("Application launch") {
            context("Repolist loaded") {
                it("should return next repo list URL and page length as 10") {
                    let sut = RepoListRepositoryImpl(provider: self.getStubbingProvider(fileName: "SuccessResponse"))
                    
                    var next: String?
                    var pageLength = 0
                    var completed = false
                    let testObserver = Signal<RepoListResponse?, RepoListRepositoryError>.Observer { (event) in
                        switch event {
                        
                        case .value(let response):
                            next = response?.next
                            if let length = response?.pagelen {
                                pageLength = length
                            }
                        case .completed:
                            completed = true
                        default:
                            fail("Observed event can only be .value and .completed.")
                        }
                    }
                    sut.getRepoList().start(testObserver)
                    expect(next).to(equal(Expected.next))
                    expect(pageLength).to(equal(Expected.pageLength))
                    expect(pageLength).to(equal(Expected.pageLength))
                    expect(completed).to(beTrue())
                }
            }
        }
    }
}


extension QuickSpec {
    func getStubbingProvider(fileName: String) -> MoyaProvider<MultiTarget> {
        do {
            let bundle = Bundle(for: type(of: self))
            guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
                fatalError()
            }
            let initStringResponseData = try Data(contentsOf: url)
            let customEndpointClosure = { (target: MultiTarget) -> Endpoint in
                return Endpoint(url: URL(target: target).absoluteString,
                                sampleResponseClosure: { .networkResponse(200, initStringResponseData) },
                                method: target.method,
                                task: target.task,
                                httpHeaderFields: target.headers)
            }
            return MoyaProvider<MultiTarget>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        } catch {
            fatalError()
        }
    }
}
