//  MedsInfoCompletionTypealiases.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

import Alamofire

// typealias Get<#Something#>Completion = (Result<Get<#Something#>Result, NetworkServiceError>) -> Void

 typealias FindMedsCompletion = (Result<[FindMedsResult], NetworkServiceError>) -> Void
