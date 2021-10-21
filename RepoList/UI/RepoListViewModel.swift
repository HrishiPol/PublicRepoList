//
//  RepoListViewModel.swift
//  RepoList
//
//  Created by Hrishikesh Pol on 21/10/21.
//

import UIKit
import Foundation
import ReactiveSwift
class RepoListViewModel {
    let useCase: GetRepoListUseCase
    
    let onAppLoad = MutableProperty<String?>(nil)
    let onNextButtonTapped = MutableProperty<String?>(nil)

    let onRepoListProcessing: Signal<RepoListResponse?, Never>
    
    init(repoListUseCase: GetRepoListUseCase) {
        self.useCase = repoListUseCase
        
        let (onRepoListProcessing, onServiceFeeProcessingObserver) = Signal<RepoListResponse?, Never>.pipe()
        self.onRepoListProcessing = onRepoListProcessing
        

        let onRepoListProcessingResult = onAppLoad.signal.flatMap(.latest) { (_) -> SignalProducer<Loadable<RepoListResponse?>, Never> in
            return self.useCase.execute()
        }
        onRepoListProcessingResult.observeValues { (result) in
            switch result {
            case .success(data: let data):
                onServiceFeeProcessingObserver.send(value: data)
            case .error(error: _):
                onServiceFeeProcessingObserver.send(value: nil)
            case .loading: break
            }
        }
        
        let onNextListLoadedResult = onNextButtonTapped.signal.flatMap(.latest) { (request) -> SignalProducer<Loadable<RepoListResponse?>, Never> in
            return self.useCase.execute()
        }
        
        onNextListLoadedResult.observeValues { (result) in
            switch result {
            case .success(data: let data):
                onServiceFeeProcessingObserver.send(value: data)
            case .error(error: _):
                onServiceFeeProcessingObserver.send(value: nil)
            case .loading: break
            }
        }
    }
}
