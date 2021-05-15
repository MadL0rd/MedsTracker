//
//  BarcodeMedsScanerViewModelProtocol.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

protocol BarcodeMedsScanerViewModelProtocol: AnyObject {
    
    var output: BarcodeMedsScanerOutput? { get }
    
    func findMeds(barcode: String, completion: @escaping FindMedsCompletion)
}
