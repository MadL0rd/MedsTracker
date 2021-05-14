//
//  AddMedsTypeSelectorViewController.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

import UIKit

final class AddMedsTypeSelectorViewController: UIViewController {

    var viewModel: AddMedsTypeSelectorViewModelProtocol!
    var coordinator: AddMedsTypeSelectorCoordinatorProtocol!
    
    private let vibroGeneratorLight = UIImpactFeedbackGenerator(style: .light)
    
    private var _view: AddMedsTypeSelectorView {
        return view as! AddMedsTypeSelectorView
    }

    override func loadView() {
        self.view = AddMedsTypeSelectorView()
    }

    override func viewDidLoad() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve
        transitioningDelegate = self
        
        super.viewDidLoad()

        configureSelf()
    }

    private func configureSelf() {
        _view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapToDismissHandler))
        _view.addGestureRecognizer(tap)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [ weak self ] in
            self?._view.startAnimation()
        }
        
        _view.barcodeButton.addTarget(self, action: #selector(buttonDidTapped(sender:)), for: .touchUpInside)
        _view.cutomMedicineButton.addTarget(self, action: #selector(buttonDidTapped(sender:)), for: .touchUpInside)
    }
    
    private func dismissThisController() {
        _view.finishAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [ weak self ] in
            self?.coordinator.dismiss()
        }
    }
    
    // MARK: - UI elements actions

    @objc private func tapToDismissHandler(recognizer: UITapGestureRecognizer) {
        let touchPoint = recognizer.location(in: self.view)
        guard touchPoint.y < (_view.bounds.height - _view.backgroundView.frame.height)
        else { return }

        dismissThisController()
    }
    
    @objc private func buttonDidTapped(sender: ButtonWithTouchSize) {
        vibroGeneratorLight.impactOccurred()
        sender.tapAnimation()
        
        switch sender {
        case _view.barcodeButton:
            coordinator.openModule(.barcodeMedsScaner)
            dismissThisController()
        default:
            break
        }
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension AddMedsTypeSelectorViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return UIPresentationController(presentedViewController: presented, presenting: presentingViewController)
    }
}

