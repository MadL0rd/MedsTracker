//
//  AppRouter.swift
//  MedsTracker
//
//  Created by Anton Tekutov on 14.05.21.
//

import UIKit

protocol AppRouter: AnyObject {

	var window: UIWindow! { get set }
    
    func handleLaunch()
}
