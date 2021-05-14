//
//  LoadingCoordinator.swift
//  MedsTracker
//
//  Created by Anton Tekutov on 14.05.21.
//

import UIKit

final class LoadingCoordinator: DefaultCoordinator {
    
    static func createModule(_ configuration: ((CustomizableLoadingViewModel) -> Void)? = nil) -> UIViewController {
        let view = LoadingViewController()
        let viewModel = LoadingViewModel()
        let coordinator = LoadingCoordinator()

        view.viewModel = viewModel
        view.coordinator = coordinator

        coordinator.transition = view

        if let configuration = configuration {
            configuration(viewModel)
        }

        return view
    }
}

// MARK: - Interface for view
extension LoadingCoordinator: LoadingCoordinatorProtocol {

}