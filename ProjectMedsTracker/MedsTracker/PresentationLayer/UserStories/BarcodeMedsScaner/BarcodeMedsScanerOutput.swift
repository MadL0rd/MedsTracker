//
//  BarcodeMedsScanerOutput.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

protocol BarcodeMedsScanerOutput: AnyObject {
    
    func returnMedicine(_ medicine: Medicine) 
}
