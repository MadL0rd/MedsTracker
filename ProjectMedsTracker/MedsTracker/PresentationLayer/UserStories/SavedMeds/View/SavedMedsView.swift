//
//  SavedMedsView.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

import UIKit

final class SavedMedsView: UIView {
    
    let addMedicineButton = ButtonWithTouchSize()
    
    var blurEffectView: UIView!
    let topLogo = UIImageView()
    let noMedicineLabel = UILabel()
    let savedMedsTable = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }

    // MARK: - Private methods
    
    private func setupView() {
        backgroundColor = R.color.backgroundLight()
        
        setupAddMedicineButton()
        
        addSubview(noMedicineLabel)
        noMedicineLabel.translatesAutoresizingMaskIntoConstraints = false
        noMedicineLabel.textColor = R.color.main2()
        noMedicineLabel.font = R.font.gilroyBold(size: 24)
        noMedicineLabel.numberOfLines = 0
        noMedicineLabel.text = R.string.localizable.thereIsNoSavedMedsNow()
        noMedicineLabel.textAlignment = .center
        
        addSubview(savedMedsTable)
        savedMedsTable.translatesAutoresizingMaskIntoConstraints = false
        savedMedsTable.separatorColor = .clear
        savedMedsTable.backgroundColor = R.color.backgroundLight()
        savedMedsTable.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 30, right: 0)
        savedMedsTable.showsVerticalScrollIndicator = false
        savedMedsTable.rowHeight = 160
        savedMedsTable.register(SavedMedicineTableViewCell.self,
                                forCellReuseIdentifier: SavedMedicineTableViewCell.identifier)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        addSubview(blurEffectView)
        blurEffectView.backgroundColor = R.color.backgroundLight()
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(topLogo)
        topLogo.translatesAutoresizingMaskIntoConstraints = false
        topLogo.image = R.image.medsTitleLogo()
        topLogo.contentMode = .scaleAspectFit
        
        makeConstraints()
    }
    
    private func setupAddMedicineButton() {
        let addButtonText = R.string.localizable.addNewMedicine()
        let addButtonFont = R.font.gilroyRegular(size: 14)!
        let textWidth = addButtonText.width(with: addButtonFont)
        addMedicineButton.frame = CGRect(x: 0,
                                         y: 0,
                                         width: textWidth + 14,
                                         height: 24)
        addMedicineButton.backgroundColor = R.color.main1()
        addMedicineButton.titleLabel?.font = addButtonFont
        addMedicineButton.setTitleColor(R.color.tintColorLight(), for: .normal)
        addMedicineButton.setTitle(addButtonText, for: .normal)
        addMedicineButton.setTitle(addButtonText, for: .selected)
        addMedicineButton.setDefaultAreaPadding()
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: topAnchor),
            blurEffectView.centerXAnchor.constraint(equalTo: centerXAnchor),
            blurEffectView.widthAnchor.constraint(equalTo: widthAnchor),
            blurEffectView.heightAnchor.constraint(equalToConstant: UIConstants.navigationBarHeight + 5),
            
            topLogo.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -3),
            topLogo.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            topLogo.widthAnchor.constraint(equalToConstant: 130),
            topLogo.heightAnchor.constraint(equalToConstant: 40),
            
            noMedicineLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            noMedicineLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            noMedicineLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            
            savedMedsTable.topAnchor.constraint(equalTo: topAnchor),
            savedMedsTable.bottomAnchor.constraint(equalTo: bottomAnchor),
            savedMedsTable.leftAnchor.constraint(equalTo: leftAnchor),
            savedMedsTable.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
