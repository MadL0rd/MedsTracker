//
//  SavedMedsViewController.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

import UIKit

final class SavedMedsViewController: UIViewController, UIViewControllerTransitioningDelegate {

    var viewModel: SavedMedsViewModelProtocol!
    var coordinator: SavedMedsCoordinatorProtocol!
    
    private let vibroGeneratorLight = UIImpactFeedbackGenerator(style: .light)
    
    private var _view: SavedMedsView {
        return view as! SavedMedsView
    }

    override func loadView() {
        self.view = SavedMedsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSelf()
    }

    private func configureSelf() {
        
        let addButtonText = R.string.localizable.addNewMedicine()
        let addButtonFont = R.font.gilroyRegular(size: 14)!
        let textWidth = addButtonText.width(with: addButtonFont)
        let addMedicineButton = ButtonWithTouchSize()
        addMedicineButton.frame = CGRect(x: 0,
                                         y: 0,
                                         width: textWidth + 14,
                                         height: 24)
        addMedicineButton.backgroundColor = R.color.main()
        addMedicineButton.titleLabel?.font = addButtonFont
        addMedicineButton.setTitleColor(R.color.tintColorLight(), for: .normal)
        addMedicineButton.setTitle(addButtonText, for: .normal)
        addMedicineButton.setTitle(addButtonText, for: .selected)
        addMedicineButton.setDefaultAreaPadding()
        addMedicineButton.addTarget(self, action: #selector(addMedicine(sender:)), for: .touchUpInside)
        let menuBarItem = UIBarButtonItem(customView: addMedicineButton)
        navigationItem.rightBarButtonItem = menuBarItem
    }
    
    // MARK: - UI elements actions

    @objc private func addMedicine(sender: UIButton) {
        sender.tapAnimation()
        vibroGeneratorLight.impactOccurred()
        coordinator.openModule(.addMedsTypeSelector, openingMode: .present)
    }
}
