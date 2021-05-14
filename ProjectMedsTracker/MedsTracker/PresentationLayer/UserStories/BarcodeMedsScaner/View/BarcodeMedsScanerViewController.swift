//
//  BarcodeMedsScanerViewController.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

import UIKit
import BarcodeScanner

final class BarcodeMedsScanerViewController: UIViewController {

    var viewModel: BarcodeMedsScanerViewModelProtocol!
    var coordinator: BarcodeMedsScanerCoordinatorProtocol!
    
    private var _view: BarcodeMedsScanerView {
        return view as! BarcodeMedsScanerView
    }

    override func loadView() {
        self.view = BarcodeMedsScanerView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSelf()
    }

    private func configureSelf() {
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self
        viewController.errorDelegate = self
        viewController.dismissalDelegate = self
        
        addChildViewControllerToView(vc: viewController, into: _view.scanerContainer)
    }
}

// MARK: - BarcodeScannerCodeDelegate

extension BarcodeMedsScanerViewController: BarcodeScannerCodeDelegate {
    
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print("code: \(code)\ntype: \(type)")
        
        viewModel.findMeds(barcode: code) { [ weak self ] result in
            switch result {
            case .success(let data):
                guard !data.isEmpty
                else {
                    controller.resetWithError(message: R.string.localizable.medicineNotFound())
                    return
                }
                AlertManager.showSuccessHUD(on: controller.view)
                controller.showSuccessAlert(with: data.first!.title, message: data.first!.text) {
                    self?.coordinator.dismiss()
                }
                print(data)
            case .failure(let error):
                print(error)
                controller.resetWithError(message: R.string.localizable.medicineNotFound())
            }
        }
    }
}

// MARK: - BarcodeScannerErrorDelegate

extension BarcodeMedsScanerViewController: BarcodeScannerErrorDelegate {
    
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }
}

// MARK: - BarcodeScannerDismissalDelegate

extension BarcodeMedsScanerViewController: BarcodeScannerDismissalDelegate {
    
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        
    }
}

