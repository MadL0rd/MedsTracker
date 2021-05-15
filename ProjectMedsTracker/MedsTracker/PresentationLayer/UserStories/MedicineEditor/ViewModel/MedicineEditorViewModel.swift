//
//  MedicineEditorViewModel.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

final class MedicineEditorViewModel {
	var output: MedicineEditorOutput?
}

// MARK: - Configuration
extension MedicineEditorViewModel: CustomizableMedicineEditorViewModel {
    
    func setMedicine(_ medicine: Medicine) {
        //        TODO: <#Issue text#>
    }
}

// MARK: - Interface for view
extension MedicineEditorViewModel: MedicineEditorViewModelProtocol {

}

