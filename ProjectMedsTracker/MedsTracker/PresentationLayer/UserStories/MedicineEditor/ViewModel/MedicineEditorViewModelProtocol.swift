//
//  MedicineEditorViewModelProtocol.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

protocol MedicineEditorViewModelProtocol: AnyObject {
    
    var output: MedicineEditorOutput? { get }
    
    var medicine: Medicine? { get set }
}
