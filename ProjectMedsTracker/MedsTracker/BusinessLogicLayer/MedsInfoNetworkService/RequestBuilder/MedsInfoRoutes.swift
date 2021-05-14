//  MedsInfoRoutes.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

import Alamofire

enum MedsInfoRoutes: String, URLConvertible {
    
    static let endpoint = "https://www.rlsnet.ru/"
    
    case findMedicine = "search_result.htm"

    func asURL() throws -> URL {
        guard let url = URL(string: MedsInfoRoutes.endpoint + self.rawValue)
        else { throw RequestBuildError.cannotCreateUrl }
        return url
    }
    
    static func makeAuthHeadersFromToken(token: String, contentType: ContentType? = nil) -> HTTPHeaders {
        if let contentType = contentType {
            return [
                "Authorization": "Token \(token)",
                "Content-Type": contentType.rawValue
            ]
        } else {
            return ["Authorization": "Token \(token)"]
        }
    }
}

enum ContentType: String {
    case json = "application/json"
    case formData = "multipart/form-data"
}
