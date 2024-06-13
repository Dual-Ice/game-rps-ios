//
//  RuleTableViewCell.swift
//  rps-game-ios
//
//  Created by Alexander Bokhulenkov on 11.06.2024.
//

import UIKit

class RulesTableViewCell: UITableViewCell {
    
    //    инконки кулак, бумага, ножницы
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        shadowContainer.addSubview(numberLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(shadowContainer)
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            numberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            numberLabel.widthAnchor.constraint(equalToConstant: 30),
            numberLabel.heightAnchor.constraint(equalToConstant: 30),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            descriptionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    конфигурация ячейки
    func configureCell(number: Int, description: String) {
        numberLabel.text = "\(number)"
        descriptionLabel.text = description
    }
    
    func configureCellWithImage(description: String, icon: UIImage?) {
        numberLabel.backgroundColor = .clear
        descriptionLabel.text = description
        iconImageView.image = icon
    }
}

