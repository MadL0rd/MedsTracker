//
//  DataRequestExecutable.swift
//  ClubhouseAvatarMaker
//
//  Created by Anton Tekutov on 14.05.21.
//

import Alamofire

protocol DataRequestExecutable {
    
    var execute: DataRequest { get }
}

extension DataRequest: DataRequestExecutable {
    
    var execute: DataRequest {
        return self
    }
}
