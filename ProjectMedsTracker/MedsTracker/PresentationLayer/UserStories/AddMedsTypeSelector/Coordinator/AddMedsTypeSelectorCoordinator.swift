//
//  AddMedsTypeSelectorCoordinator.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

import UIKit

final class AddMedsTypeSelectorCoordinator: DefaultCoordinator {
    
    static func createModule(_ configuration: ((CustomizableAddMedsTypeSelectorViewModel) -> Void)? = nil) -> UIViewController {
        let view = AddMedsTypeSelectorViewController()
        let viewModel = AddMedsTypeSelectorViewModel()
        let coordinator = AddMedsTypeSelectorCoordinator()

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
extension AddMedsTypeSelectorCoordinator: AddMedsTypeSelectorCoordinatorProtocol {

}