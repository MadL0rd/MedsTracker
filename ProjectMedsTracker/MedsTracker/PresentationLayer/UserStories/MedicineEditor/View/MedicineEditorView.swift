//
//  MedicineEditorView.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

import UIKit

final class MedicineEditorView: UIView {

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

        makeConstraints()
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}