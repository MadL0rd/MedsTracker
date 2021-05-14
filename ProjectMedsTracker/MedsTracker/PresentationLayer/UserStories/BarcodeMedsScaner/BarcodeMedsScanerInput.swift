//
//  BarcodeMedsScanerInput.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

protocol CustomizableBarcodeMedsScanerViewModel: AnyObject {
    
    var output: BarcodeMedsScanerOutput? { get set }
}