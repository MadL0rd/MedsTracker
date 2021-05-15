//  MedsInfoRequestResults.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//
//  Codable result structures

import Foundation

struct FindMedsResult {
    
    let title: String
    let text: String
    let url: String
    
    var medicine: Medicine {
        var count = 0
        if let countString = text
            .split(separator: ",").first?
            .split(separator: " ").last,
           let countInt = Int(countString) {
            count = countInt
        }
        
        return Medicine(title: title,
                        textInfo: text,
                        url: url,
                        image: nil,
                        shelfLifeDate: nil,
                        itemsCount: count)
                        
    }
}
