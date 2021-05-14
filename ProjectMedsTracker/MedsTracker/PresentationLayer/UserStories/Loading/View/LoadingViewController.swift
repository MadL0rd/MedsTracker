//
//  LoadingViewController.swift
//  MedsTracker
//
//  Created by Anton Tekutov on 14.05.21.
//

import UIKit

final class LoadingViewController: UIViewController {
    
    var viewModel: LoadingViewModelProtocol!
    var coordinator: LoadingCoordinatorProtocol!
    
    private var _view: LoadingView {
        return view as! LoadingView
    }
    
    override func loadView() {
        self.view = LoadingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSelf()
    }
    
    private func configureSelf() {
        viewModel.startConfiguration()
        
        _view.hideLogo()
        DispatchQueue.main.asyncAfter(deadline: .now() + _view.hideLogoDuration * 0.6) { [ weak self ] in
            self?.coordinator.openModule(.savedMeds, openingMode: .showInNewRootNavigationStack)
        }
    }
}
