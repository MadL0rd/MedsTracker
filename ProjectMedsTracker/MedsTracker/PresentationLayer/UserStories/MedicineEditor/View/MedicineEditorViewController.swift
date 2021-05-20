//
//  MedicineEditorViewController.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

import UIKit

final class MedicineEditorViewController: UIViewController {

    var viewModel: MedicineEditorViewModelProtocol!
    var coordinator: MedicineEditorCoordinatorProtocol!
    
    private var _view: MedicineEditorView {
        return view as! MedicineEditorView
    }

    override func loadView() {
        self.view = MedicineEditorView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSelf()
    }

    private func configureSelf() {
        
        setupMedicine()
    }
    
    private func setupMedicine() {
        guard let medicine = viewModel.medicine
        else { return }
        
        if let _ = medicine.url {
            _view.aboutButton.addTarget(self, action: #selector(infoButtonTapped(sender:)), for: .touchUpInside)
            _view.aboutKekButton.addTarget(self, action: #selector(infoButtonTapped(sender:)), for: .touchUpInside)
            let menuBarItem = UIBarButtonItem(customView: _view.aboutButton)
            navigationItem.rightBarButtonItem = menuBarItem
        }
        
        _view.titleLabel.text = medicine.title
        _view.infoLabel.text = medicine.textInfo
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 30
        let attributedString = NSMutableAttributedString(string: medicine.textInfo!,
                                                         attributes: [ .paragraphStyle: paragraphStyle ])
        _view.infoLabel.attributedText = attributedString
    }
    
    // MARK: - UI elements actions

    @objc private func infoButtonTapped(sender: UIView) {
        sender.tapAnimation()
        guard let url = URL(string: viewModel.medicine?.url ?? "")
        else { return }
        UIApplication.shared.open(url)
    }
}
