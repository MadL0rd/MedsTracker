//
//  BarcodeMedsScanerView.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

import UIKit

final class BarcodeMedsScanerView: UIView {
    
    let navigationBackground = UIView()
    let scanerContainer = UIView()

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
        addSubview(scanerContainer)
        scanerContainer.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(navigationBackground)
        navigationBackground.translatesAutoresizingMaskIntoConstraints = false
        navigationBackground.backgroundColor = R.color.backgroundLight()
        navigationBackground.alpha = 0.9

        makeConstraints()
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            navigationBackground.topAnchor.constraint(equalTo: topAnchor),
            navigationBackground.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            navigationBackground.centerXAnchor.constraint(equalTo: centerXAnchor),
            navigationBackground.widthAnchor.constraint(equalTo: widthAnchor),
            
            scanerContainer.topAnchor.constraint(equalTo: topAnchor),
            scanerContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            scanerContainer.rightAnchor.constraint(equalTo: rightAnchor),
            scanerContainer.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }
}
