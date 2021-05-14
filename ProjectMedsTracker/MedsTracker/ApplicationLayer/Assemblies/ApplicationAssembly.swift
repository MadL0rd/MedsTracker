//
//  ApplicationAssembly.swift
//  MedsTracker
//
//  Created by Anton Tekutov on 14.05.21.
//

import Foundation

class ApplicationAssembly {
    
    static var appRouter: AppRouter = {
        return MainAppRouter()
    }()
}
