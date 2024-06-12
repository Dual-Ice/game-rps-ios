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
    
    private let numberLebel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: "darkTangerineTextColor")
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 30/2
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
        contentView.addSubview(iconImageView)
        contentView.addSubview(numberLebel)
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
                    numberLebel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
                    numberLebel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                    numberLebel.widthAnchor.constraint(equalToConstant: 30),
                    numberLebel.heightAnchor.constraint(equalToConstant: 30),
                    
                    descriptionLabel.leadingAnchor.constraint(equalTo: numberLebel.trailingAnchor, constant: 10),
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
        numberLebel.text = "\(number)"
        descriptionLabel.text = description
    }
    
    func configureCellWithImage(description: String, icon: UIImage?) {
        numberLebel.backgroundColor = .clear
        descriptionLabel.text = description
        iconImageView.image = icon
    }
}
