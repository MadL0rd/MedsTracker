//
//  MedicineEditorOutput.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

protocol MedicineEditorOutput: AnyObject {
    
    func returnEditedMedicine(_ medicine: Medicine)
}
