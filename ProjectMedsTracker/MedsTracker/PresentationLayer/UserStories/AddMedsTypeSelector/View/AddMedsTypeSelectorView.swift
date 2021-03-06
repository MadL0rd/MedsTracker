//
//  AddMedsTypeSelectorView.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

import UIKit

final class AddMedsTypeSelectorView: UIView {
    
    let padding: CGFloat = UIConstants.screenBounds.width * 0.08
    let backgroundHeight: CGFloat = UIConstants.screenBounds.width * 0.6
    
    let backgroundView = UIView()
    let customMedicineButton = ButtonWithTouchSize()
    let barcodeButton = ButtonWithTouchSize()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    // MARK: - Public methods
    
    func startAnimation() {
        UIView.animate(withDuration: 0.3) { [ weak self ] in
            self?.backgroundView.transform = .init(scaleX: 1, y: 1)
            self?.backgroundColor = R.color.backgroundDark()?.withAlphaComponent(0.25)
        }
    }
    
    func finishAnimation() {
        UIView.animate(withDuration: 0.3) { [ weak self ] in
            guard let self = self
            else { return }
            self.backgroundView.transform = .init(translationX: 0, y: self.backgroundHeight)
            self.backgroundColor = .clear
        }
    }

    // MARK: - Private methods
    
    private func setupView() {
        backgroundColor = .clear
        layer.shadowColor = R.color.backgroundDark()?.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
        layer.masksToBounds = false
        clipsToBounds = false

        addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = R.color.backgroundLight()
        backgroundView.roundCorners(corners: [.topLeft, .topRight], radius: 50)
        backgroundView.isUserInteractionEnabled = true
        backgroundView.transform = .init(translationX: 0, y: backgroundHeight)
        
        setupButton(button: customMedicineButton, image: R.image.custom())
        setupButton(button: barcodeButton, image: R.image.barcode())
        customMedicineButton.backgroundColor = R.color.main1()
        barcodeButton.backgroundColor = R.color.main2()

        makeConstraints()
    }
    
    private func setupButton(button: ButtonWithTouchSize, image: UIImage?) {
        backgroundView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.tintColor = R.color.tintColorLight()
        
        button.setImage(image, for: .normal)
        button.setImage(image, for: .highlighted)
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -backgroundHeight),
            backgroundView.widthAnchor.constraint(equalTo: widthAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            customMedicineButton.widthAnchor.constraint(equalToConstant: (UIConstants.screenBounds.width - (padding * 3)) / 2),
            customMedicineButton.heightAnchor.constraint(equalTo: customMedicineButton.widthAnchor),
            customMedicineButton.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor, constant: padding / -2),
            customMedicineButton.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: padding),
            
            barcodeButton.widthAnchor.constraint(equalTo: customMedicineButton.widthAnchor),
            barcodeButton.heightAnchor.constraint(equalTo: customMedicineButton.widthAnchor),
            barcodeButton.centerYAnchor.constraint(equalTo: customMedicineButton.centerYAnchor),
            barcodeButton.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -padding)
        ])
    }
}
