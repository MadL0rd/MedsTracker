//  MedsInfoNetworkService.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

import Alamofire

class MedsInfoNetworkService: NetworkService {
    
    static let shared: MedsInfoNetworkServiceProtocol = MedsInfoNetworkService()
    
    private let requestBuilder = MedsInfoRequestBuilder.self
    
    private func generateFindMedsResultFromHtml(_ html: String) -> [FindMedsResult] {
        guard let startRange = html.range(of: "в штрих-кодах:")
        else { return [] }
        
        var html = html
        
        html.removeSubrange(html.startIndex ..< startRange.upperBound)
        let medsEnd = html.range(of: "lsstyle>")
        html.removeSubrange(medsEnd!.lowerBound ..< html.endIndex)
        
        html = html.replacingOccurrences(of: "<sup>", with: "")
        html = html.replacingOccurrences(of: "</sup>", with: "")
        html = html.replacingOccurrences(of: "&nbsp;", with: " ")
        html = html.replacingOccurrences(of: "&nbsp", with: " ")

        var result = [FindMedsResult]()
        
        while html.contains("<a href=\"") {
            let hrefBegin = html.range(of: "<a href=\"")
            html.removeSubrange(html.startIndex ..< hrefBegin!.upperBound)
            
            let hrefEnd = html.range(of: "\">")
            
            var link = html
            link.removeSubrange(hrefEnd!.lowerBound ..< link.endIndex)
            link = "https:" + link
            
            html.removeSubrange(html.startIndex ..< hrefEnd!.upperBound)
            let textEnd = html.range(of: "</a>")
            
            var text = html
            text.removeSubrange(textEnd!.lowerBound ..< html.endIndex)
            
            var title = text
            let titleEnd = title.range(of: "; ")
            title.removeSubrange(titleEnd!.lowerBound ..< title.endIndex)
            text.removeSubrange(text.startIndex ..< titleEnd!.upperBound)
            
            let searchMedicineItem = FindMedsResult(title: title, text: text, url: link)
            result.append(searchMedicineItem)
            
            html.removeSubrange(html.startIndex ..< textEnd!.upperBound)
        }
        
        return result
    }
}

extension MedsInfoNetworkService: MedsInfoNetworkServiceProtocol {
    
    func findMedsByBarcode(barcode: String, completion: @escaping FindMedsCompletion) {
        requestBuilder.findMedicine(barcode: barcode).execute
            .response { [ weak self ] response in
                guard let self = self
                else { return }
                switch response.result {
                case .success:
                    guard let data = response.data,
                          let html = String(data: data, encoding: String.Encoding.windowsCP1251)
                    else { completion(.failure(.cannotParceData)); return }
                    
                    let result = self.generateFindMedsResultFromHtml(html)
                    completion(.success(result))
                    
                case .failure:
                    if let code = response.error?.responseCode,
                       let error = NetworkServiceError(rawValue: code) {
                        completion(.failure(error))
                    }
                    else {
                        completion(.failure(.unknown))
                        return
                    }
                }
            }
    }

}
