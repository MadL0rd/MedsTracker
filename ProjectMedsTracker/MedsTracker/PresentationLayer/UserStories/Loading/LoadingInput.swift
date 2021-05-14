//
//  LoadingInput.swift
//  MedsTracker
//
//  Created by Anton Tekutov on 14.05.21.
//

protocol CustomizableLoadingViewModel: AnyObject {
    
    var output: LoadingOutput? { get set }
}