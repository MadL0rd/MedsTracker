//
//  SavedMedicineTableViewCell.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

import UIKit

protocol SavedMedicineTableViewCellDelegate: AnyObject {
    
    func takeMedicine(_ cell: SavedMedicineTableViewCell, countMedsToTake: Int)
}

class SavedMedicineTableViewCell: UITableViewCell {
    
    weak var delegate: SavedMedicineTableViewCellDelegate?
    
    var maxTabletCount = 5
    var currentTabletCount: Int?
    
    let background = UIView()
    let takeLabel = UILabel()
    let takeExpandableView = UIView()
    let expandableViewMinWidth: CGFloat = 52
    var takeExpandableViewWidth: NSLayoutConstraint!
    let expandedViewCount = PaddingLabel(top: 5, bottom: 5, left: 8, right: 8)
    
    let medicineImageView = UIImageView()
    let countLabel = PaddingLabel(top: 5, bottom: 5, left: 8, right: 10)
    let titleLabel = UILabel()
    let shelfLifeDateLabel = UILabel()
    let labelsStack = UIStackView()
    
    static var identifier: String {
        String(describing: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - UI elements actions

    @objc func expandView(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            UIView.animate(withDuration: 0.3) { [ weak self ] in
                self?.expandedViewCount.alpha = 1
            }
        }
        switch sender.state {
        case .ended:
            takeExpandableViewWidth.constant = expandableViewMinWidth
            sender.setTranslation(CGPoint.zero, in: contentView)
            if let currentTabletCount = currentTabletCount {
                delegate?.takeMedicine(self, countMedsToTake: currentTabletCount)
            }
            currentTabletCount = nil
            UIView.animate(withDuration: 0.3) { [ weak self ] in
                self?.layoutIfNeeded()
                self?.expandedViewCount.alpha = 0
            }
        default:
            let translation = sender.translation(in: contentView)
            takeExpandableViewWidth.constant = min(max(translation.x + takeExpandableViewWidth.constant, expandableViewMinWidth), background.frame.width)
            sender.setTranslation(CGPoint.zero, in: contentView)
            let oneSectionSize = background.frame.width / CGFloat(maxTabletCount + 1)
            var tabletsCount = Int(takeExpandableViewWidth.constant / oneSectionSize)
            tabletsCount = min(tabletsCount, maxTabletCount)
            if currentTabletCount != tabletsCount {
                VibroGenerator.light.impactOccurred()
                currentTabletCount = tabletsCount
                expandedViewCount.text = "\(tabletsCount) \(R.string.localizable.pcs())"
            }
            UIView.animate(withDuration: 0.1) { [ weak self ] in
                self?.layoutIfNeeded()
            }
        }
    }
    
    // MARK: - Public methods
    
    func setContent(_ content: Medicine, index: Int) {
        if content.itemsCount == 0 {
            takeExpandableView.isUserInteractionEnabled = false
            takeExpandableView.backgroundColor = R.color.gray()
            countLabel.backgroundColor = R.color.gray()
        } else {
            takeExpandableView.isUserInteractionEnabled = true
            takeExpandableView.backgroundColor = index % 2 == 0 ? R.color.main1() : R.color.main2()
            expandedViewCount.textColor = takeExpandableView.backgroundColor
            countLabel.backgroundColor = R.color.main1()
        }
        titleLabel.text = content.title
        shelfLifeDateLabel.text = R.string.localizable.shelfLifeDate()
        countLabel.text = "\(content.itemsCount) \(R.string.localizable.pcs())"
        
        if let date = content.shelfLifeDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            shelfLifeDateLabel.text? += " " + formatter.string(from: date)
        } else {
            shelfLifeDateLabel.text? += " --.--.----"
        }
    }
    
    // MARK: - Private setup methods
    
    private func setupView() {
        backgroundColor = R.color.backgroundLight()
        
        let clearView = UIView()
        clearView.backgroundColor = .clear
        selectedBackgroundView = clearView
        
        contentView.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.backgroundColor = R.color.lightGray()
        background.layer.cornerRadius = 10
        background.layer.masksToBounds = true
        
        setupMedicineInfo()
        setupTakeMeds()
                
        makeConstraints()
    }
    
    private func setupMedicineInfo() {
        background.addSubview(medicineImageView)
        medicineImageView.translatesAutoresizingMaskIntoConstraints = false
        medicineImageView.layer.cornerRadius = 20
        medicineImageView.image = R.image.defaultImage()
        medicineImageView.contentMode = .scaleAspectFill
        medicineImageView.layer.masksToBounds = true
        
        background.addSubview(countLabel)
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.backgroundColor = R.color.main1()
        countLabel.textColor = R.color.tintColorLight()
        countLabel.font = R.font.gilroySemibold(size: 16)
        countLabel.text = "1 \(R.string.localizable.pcs())"
        countLabel.roundCorners(corners: [.bottomLeft, .bottomRight, .topLeft, .topRight], radius: 5)
        
        background.addSubview(labelsStack)
        labelsStack.translatesAutoresizingMaskIntoConstraints = false
        labelsStack.axis = .vertical
        labelsStack.spacing = 20
        
        labelsStack.addArrangedSubview(titleLabel)
        titleLabel.textColor = R.color.tintColorDark()
        titleLabel.font = R.font.gilroyBold(size: 16)
        titleLabel.numberOfLines = 3
        
        labelsStack.addArrangedSubview(shelfLifeDateLabel)
        shelfLifeDateLabel.textColor = R.color.gray()
        shelfLifeDateLabel.font = R.font.gilroyRegular(size: 14)
        shelfLifeDateLabel.numberOfLines = 3
    }
    
    private func setupTakeMeds() {
        background.addSubview(takeExpandableView)
        takeExpandableView.translatesAutoresizingMaskIntoConstraints = false
        takeExpandableView.backgroundColor = R.color.main2()
        takeExpandableView.isUserInteractionEnabled = true
        takeExpandableView.layer.masksToBounds = true
        let pan = UIPanGestureRecognizer(target: self, action: #selector(expandView(_:)))
        takeExpandableView.addGestureRecognizer(pan)
        
        takeExpandableView.addSubview(expandedViewCount)
        expandedViewCount.translatesAutoresizingMaskIntoConstraints = false
        expandedViewCount.alpha = 0
        expandedViewCount.backgroundColor = R.color.tintColorLight()
        expandedViewCount.textColor = R.color.tintColorLight()
        expandedViewCount.font = R.font.gilroySemibold(size: 20)
        expandedViewCount.text = "12 \(R.string.localizable.pcs())"
        expandedViewCount.roundCorners(corners: [.bottomLeft, .topLeft], radius: 5)
        
        background.addSubview(takeLabel)
        takeLabel.isUserInteractionEnabled = false
        takeLabel.translatesAutoresizingMaskIntoConstraints = false
        takeLabel.textColor = R.color.tintColorLight()
        takeLabel.font = R.font.gilroyBold(size: 16)
        takeLabel.numberOfLines = 0
        let takeText = R.string.localizable.takeMeds()
        var verticalTakeText = ""
        takeText.forEach { letter in
            verticalTakeText.append(letter)
            verticalTakeText += "\n"
        }
        verticalTakeText.removeLast()
        takeLabel.text = verticalTakeText
        takeLabel.textAlignment = .center
        
        let delta = (UIConstants.screenBounds.width - expandableViewMinWidth) / 6
        for i in 1 ... maxTabletCount {
            let tablet = UIImageView(image: R.image.tablet())
            takeExpandableView.addSubview(tablet)
            tablet.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                tablet.centerYAnchor.constraint(equalTo: centerYAnchor),
                tablet.centerXAnchor.constraint(equalTo: background.rightAnchor, constant: -delta * CGFloat(i)),
                tablet.widthAnchor.constraint(equalToConstant: 25),
                tablet.heightAnchor.constraint(equalTo: tablet.widthAnchor)
            ])
        }
    }
    
    private func makeConstraints() {
        takeExpandableViewWidth = takeExpandableView.widthAnchor.constraint(equalToConstant: expandableViewMinWidth)
        NSLayoutConstraint.activate([
            background.centerYAnchor.constraint(equalTo: centerYAnchor),
            background.centerXAnchor.constraint(equalTo: centerXAnchor),
            background.widthAnchor.constraint(equalTo: widthAnchor, constant: -30),
            background.heightAnchor.constraint(equalTo: heightAnchor, constant: -10),
            
            takeLabel.leftAnchor.constraint(equalTo: background.leftAnchor, constant: 20),
            takeLabel.centerYAnchor.constraint(equalTo: background.centerYAnchor),
            
            takeExpandableView.centerYAnchor.constraint(equalTo: background.centerYAnchor),
            takeExpandableView.leftAnchor.constraint(equalTo: background.leftAnchor),
            takeExpandableView.heightAnchor.constraint(equalTo: background.heightAnchor),
            takeExpandableViewWidth,
            
            expandedViewCount.rightAnchor.constraint(equalTo: takeExpandableView.rightAnchor),
            expandedViewCount.topAnchor.constraint(equalTo: takeExpandableView.topAnchor, constant: 15),
            
            medicineImageView.leftAnchor.constraint(equalTo: background.leftAnchor, constant: expandableViewMinWidth + 10),
            medicineImageView.rightAnchor.constraint(equalTo: background.centerXAnchor, constant: -10),
            medicineImageView.centerYAnchor.constraint(equalTo: background.centerYAnchor),
            medicineImageView.heightAnchor.constraint(equalTo: background.heightAnchor, constant: -20),
            
            countLabel.topAnchor.constraint(equalTo: medicineImageView.topAnchor, constant: -5),
            countLabel.rightAnchor.constraint(equalTo: medicineImageView.rightAnchor, constant: 5),
            
            labelsStack.centerYAnchor.constraint(equalTo: background.centerYAnchor),
            labelsStack.leftAnchor.constraint(equalTo: medicineImageView.rightAnchor, constant: 10),
            labelsStack.rightAnchor.constraint(equalTo: background.rightAnchor, constant: -10)
        ])
    }
}

