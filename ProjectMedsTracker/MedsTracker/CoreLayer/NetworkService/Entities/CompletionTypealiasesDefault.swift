//
//  CompletionTypealiasesDefault.swift
//  ClubhouseAvatarMaker
//
//  Created by Anton Tekutov on 14.05.21.
//

import Alamofire

typealias DefaultRequestCompletion<T: Codable> = (Result<T, NetworkServiceError>) -> Void
