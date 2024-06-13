//
//  RuleTableViewCell.swift
//  rps-game-ios
//
//  Created by Alexander Bokhulenkov on 11.06.2024.
//

import UIKit

class RulesTableViewCell: UITableViewCell {
    
    static let identifier = RulesTableViewCell.debugDescription()
    
    //    Контейнер для тени кнопок
    private let shadowContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: "darkTangerineTextColor")
        label.textAlignment = .center
        label.layer.cornerRadius = 30/2
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //    MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        shadowContainer.addSubview(numberLabel)
        contentView.addSubview(shadowContainer)
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            shadowContainer.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            shadowContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            shadowContainer.widthAnchor.constraint(equalToConstant: 30),
            shadowContainer.heightAnchor.constraint(equalToConstant: 30),

            numberLabel.centerXAnchor.constraint(equalTo: shadowContainer.centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: shadowContainer.centerYAnchor),
            numberLabel.widthAnchor.constraint(equalToConstant: 30),
            numberLabel.heightAnchor.constraint(equalToConstant: 30),

            descriptionLabel.leftAnchor.constraint(equalTo: shadowContainer.rightAnchor, constant: 10),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            descriptionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10), // Ensure there is some space from the top
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10) // Ensure there is some space from the bottom
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    конфигурация ячейки
    func configureCell(number: Int, description: NSAttributedString) {
        numberLabel.text = "\(number)"
        descriptionLabel.attributedText = description
    }
}

