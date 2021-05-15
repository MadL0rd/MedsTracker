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
    
    var savedMeds = [Medicine]()
    
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
        
        _view.savedMedsTable.dataSource = self
        _view.savedMedsTable.delegate = self

        _view.addMedicineButton.addTarget(self, action: #selector(addMedicine(sender:)), for: .touchUpInside)
        let menuBarItem = UIBarButtonItem(customView: _view.addMedicineButton)
        navigationItem.rightBarButtonItem = menuBarItem
        
        reloadData()
    }
    
    // MARK: - UI elements actions

    @objc private func addMedicine(sender: UIButton) {
        sender.tapAnimation()
        vibroGeneratorLight.impactOccurred()
        coordinator.openModuleWithOutput(.addMedsTypeSelector(output: self),
                                         openingMode: .present)
    }
    
    func reloadData() {
        _view.savedMedsTable.isHidden = savedMeds.isEmpty
        _view.savedMedsTable.reloadData()
    }
}

// MARK: - Meds table management

extension SavedMedsViewController: UITableViewDataSource, UITableViewDelegate, SavedMedicineTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedMeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SavedMedicineTableViewCell.identifier,
                                                 for: indexPath) as! SavedMedicineTableViewCell
        
        cell.delegate = self
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        if let medicine = savedMeds[exist: indexPath.row] {
            cell.setContent(medicine, index: indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func takeMedicine(_ cell: SavedMedicineTableViewCell, countMedsToTake: Int) {
        guard countMedsToTake != 0,
              let indexPath = _view.savedMedsTable.indexPath(for: cell)
        else { return }
        savedMeds[indexPath.row].itemsCount -= countMedsToTake
        if savedMeds[indexPath.row].itemsCount <= 0 {
            savedMeds[indexPath.row].itemsCount = 0
        }
        VibroGenerator.heavy.impactOccurred()
        cell.tapAnimation()
        cell.setContent(savedMeds[indexPath.row], index: indexPath.row)
    }
}

// MARK: - AddMedsTypeSelectorOutput

extension SavedMedsViewController: AddMedsTypeSelectorOutput {
    
    func returnTypeOfMedicineToAdd(_ type: TypeOfMedicineToAdd) {
        switch type {
        case .barcode:
            coordinator.openModuleWithOutput(.barcodeMedsScaner(output: self))
        case .custom:
            coordinator.openModuleWithOutput(.medicineEditor(output: self))
        }
    }
}

// MARK: - BarcodeMedsScanerOutput

extension SavedMedsViewController: BarcodeMedsScanerOutput {
    
    func returnMedicine(_ medicine: Medicine) {
        savedMeds.append(medicine)
        reloadData()
    }
}

// MARK: - MedicineEditorOutput

extension SavedMedsViewController: MedicineEditorOutput {
    
    func returnEditedMedicine(_ medicine: Medicine) {
        print(medicine)
    }
}
