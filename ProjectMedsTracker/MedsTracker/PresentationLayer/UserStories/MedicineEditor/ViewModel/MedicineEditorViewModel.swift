//
//  MedicineEditorViewModel.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

final class MedicineEditorViewModel {
	var output: MedicineEditorOutput?
    
    var medicine: Medicine?
}

// MARK: - Configuration
extension MedicineEditorViewModel: CustomizableMedicineEditorViewModel {
    
}

// MARK: - Interface for view
extension MedicineEditorViewModel: MedicineEditorViewModelProtocol {

}

