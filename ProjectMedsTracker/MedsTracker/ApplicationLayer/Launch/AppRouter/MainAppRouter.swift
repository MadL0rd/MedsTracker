//
//  MainAppRouter.swift
//  MedsTracker
//
//  Created by Anton Tekutov on 14.05.21.
//

import UIKit

class MainAppRouter: AppRouter {
    
    var window: UIWindow!
    
    private func openModule(_ controller: UIViewController) {
        createWindowIfNeeded()
        window.backgroundColor = .black
        window.rootViewController = controller
        makeKeyAndVisibleIfNeeded()
    }
    
    private func createWindowIfNeeded() {
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
        }
    }
    
    private func makeKeyAndVisibleIfNeeded() {
        if !window.isKeyWindow {
            window.makeKeyAndVisible()
        }
    }
    
    func handleLaunch() {
        openLoadingModule()
    }
    
    func openLoadingModule() {
        let rootVC = UINavigationController()
        UIStyleManager.navigationControllerTransparent(rootVC)
        let vc = LoadingCoordinator.createModule()
        rootVC.show(vc, sender: nil)
        openModule(rootVC)
    }
}
