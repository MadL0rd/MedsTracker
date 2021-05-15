//
//  MedicineEditorCoordinator.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

import UIKit

final class MedicineEditorCoordinator: DefaultCoordinator {
    
    static func createModule(_ configuration: ((CustomizableMedicineEditorViewModel) -> Void)? = nil) -> UIViewController {
        let view = MedicineEditorViewController()
        let viewModel = MedicineEditorViewModel()
        let coordinator = MedicineEditorCoordinator()

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
extension MedicineEditorCoordinator: MedicineEditorCoordinatorProtocol {

}