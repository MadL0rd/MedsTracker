//
//  SavedMedsCoordinator.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

import UIKit

final class SavedMedsCoordinator: DefaultCoordinator {
    
    static func createModule(_ configuration: ((CustomizableSavedMedsViewModel) -> Void)? = nil) -> UIViewController {
        let view = SavedMedsViewController()
        let viewModel = SavedMedsViewModel()
        let coordinator = SavedMedsCoordinator()

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
extension SavedMedsCoordinator: SavedMedsCoordinatorProtocol {

    func openMedsEditor(medicine: Medicine, output: MedicineEditorOutput) {
        let vc = MedicineEditorCoordinator.createModule { viewModel in
            viewModel.output = output
            viewModel.medicine = medicine
        }
        transition.showInRootNavigationController(vc)
    }
}
