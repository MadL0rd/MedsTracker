//
//  MedicineEditorView.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

import UIKit

final class MedicineEditorView: UIView {
    
    let aboutButton = ButtonWithTouchSize()
    let aboutKekButton = ButtonWithTouchSize()

    let scroll = UIScrollView()
    let stack = UIStackView()
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let infoLabel = UILabel()

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
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        
        stack.addArrangedSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = R.image.defaultImage()
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        
        stack.addArrangedSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = R.color.tintColorDark()
        titleLabel.font = R.font.gilroyBold(size: 24)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        stack.addArrangedSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.textColor = R.color.tintColorDark()
        infoLabel.font = R.font.gilroyRegular(size: 16)
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .left
        
        addSubview(aboutKekButton)
        aboutKekButton.translatesAutoresizingMaskIntoConstraints = false
        aboutKekButton.backgroundColor = R.color.main1()
        aboutKekButton.layer.cornerRadius = 20
        aboutKekButton.titleLabel?.font = R.font.gilroyBold(size: 24)
        aboutKekButton.setTitleColor(R.color.tintColorLight(), for: .normal)
        aboutKekButton.setTitle(R.string.localizable.info(), for: .normal)
        aboutKekButton.setTitle(R.string.localizable.info(), for: .selected)
        aboutKekButton.setDefaultAreaPadding()
        
        stack.setCustomSpacing(60, after: aboutKekButton)

        makeConstraints()
    }
    
    private func setupAddMedicineButton() {
        let aboutButtonText = R.string.localizable.info()
        let aboutButtonFont = R.font.gilroyRegular(size: 14)!
        let textWidth = aboutButtonText.width(with: aboutButtonFont)
        aboutButton.frame = CGRect(x: 0,
                                   y: 0,
                                   width: textWidth + 14,
                                   height: 24)
        aboutButton.backgroundColor = R.color.main1()
        aboutButton.titleLabel?.font = aboutButtonFont
        aboutButton.setTitleColor(R.color.tintColorLight(), for: .normal)
        aboutButton.setTitle(aboutButtonText, for: .normal)
        aboutButton.setTitle(aboutButtonText, for: .selected)
        aboutButton.setDefaultAreaPadding()
        
        aboutButton.isHidden = true
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.widthAnchor.constraint(equalTo: widthAnchor, constant: -30),

            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            aboutKekButton.heightAnchor.constraint(equalToConstant: 100),
            aboutKekButton.widthAnchor.constraint(equalTo: stack.widthAnchor, constant: -60),
            aboutKekButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            aboutKekButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
