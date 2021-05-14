//  MedsInfoNetworkServiceProtocol.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

import Foundation

protocol MedsInfoNetworkServiceProtocol: AnyObject {
    
    func findMedsByBarcode(barcode: String, completion: @escaping FindMedsCompletion)
}

