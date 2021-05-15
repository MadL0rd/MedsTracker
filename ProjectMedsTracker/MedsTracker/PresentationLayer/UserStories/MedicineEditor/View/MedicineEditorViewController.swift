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
        
    }
}
