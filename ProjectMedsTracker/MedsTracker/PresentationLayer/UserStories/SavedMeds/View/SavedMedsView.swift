//
//  SavedMedsView.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

import UIKit

final class SavedMedsView: UIView {
    
    let noMedicineLabel = UILabel()

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
        
        addSubview(noMedicineLabel)
        noMedicineLabel.translatesAutoresizingMaskIntoConstraints = false
        noMedicineLabel.textColor = R.color.main()
        noMedicineLabel.font = R.font.gilroyBold(size: 24)
        noMedicineLabel.numberOfLines = 0
        noMedicineLabel.text = R.string.localizable.thereIsNoSavedMedsNow()
        noMedicineLabel.textAlignment = .center

        makeConstraints()
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            noMedicineLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            noMedicineLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            noMedicineLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
        ])
    }
}
