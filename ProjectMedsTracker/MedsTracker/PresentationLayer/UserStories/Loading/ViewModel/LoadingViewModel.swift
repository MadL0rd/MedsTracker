//
//  LoadingViewModel.swift
//  MedsTracker
//
//  Created by Anton Tekutov on 14.05.21.
//

final class LoadingViewModel {
	var output: LoadingOutput?
}

// MARK: - Configuration
extension LoadingViewModel: CustomizableLoadingViewModel {

}

// MARK: - Interface for view
extension LoadingViewModel: LoadingViewModelProtocol {
    
    func startConfiguration() {
        
    }
}

