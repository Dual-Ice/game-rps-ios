//
//  RuleTableViewCell.swift
//  rps-game-ios
//
//  Created by Alexander Bokhulenkov on 11.06.2024.
//

import UIKit

class ActionCell: UITableViewCell {
    
    static let identifier = ActionCell.debugDescription()
    
    //    инконки кулак, бумага, ножницы
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        contentView.addSubview(iconImageView)
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 40),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            
            descriptionLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            descriptionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10), // Ensure there is some space from the top
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10) // Ensure there is some space from the bottom
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(description: NSAttributedString, icon: UIImage?) {
        descriptionLabel.attributedText = description
        iconImageView.image = icon
    }
}

