//  MedsInfoRequestBuilder.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

import Alamofire

enum MedsInfoRequestBuilder {
    
    case findMedicine(barcode: String)
}

extension MedsInfoRequestBuilder: DataRequestExecutable {
    
    var execute: DataRequest {
        switch self {
        case .findMedicine(barcode: let barcode):
            let parameters: [String: Any] = ["word": barcode]
            return AF.request(MedsInfoRoutes.findMedicine, parameters: parameters)
        }
    }
}
