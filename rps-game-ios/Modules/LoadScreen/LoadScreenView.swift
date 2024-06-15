//
//  LoadScreenView.swift
//  rps-game-ios
//
//  Created by Alexander on 11.06.24.
//

import UIKit

final class LoadScreenView: UIView {
    // MARK: - Private properties
    
    // Background image view
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.CustomImage.winBackgroundImage
        return imageView
    }()
    
    // Player one image view
    private lazy var playerOneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Player two image view
    private lazy var playerTwoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Player one victories label
    private lazy var victoriesLabelPlayerOne: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // Player one loses label
    private lazy var loseLabelPlayerOne: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // Player two victories label
    private lazy var victoriesLabelPlayerTwo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // Player two loses label
    private lazy var loseLabelPlayerTwo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // VS label
    private let vsLabel = LabelFactory.makeLargeLabel(text: "VS")
    
    // Get ready label
    private let getReadyLabel = LabelFactory.makeSmallLabel(text: "Get ready...")
    
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
        layoutViews()
    }
    
    // MARK: - Layout Views
    func layoutViews() {
        NSLayoutConstraint.activate([
            // Background image constraints
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            // VS label constraints
            vsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            vsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            // Get ready label constraints
            getReadyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            getReadyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -56),
            
            // Player one image constraints
            playerOneImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            playerOneImageView.topAnchor.constraint(equalTo: topAnchor, constant: 153),
            
            // Player two image constraints
            playerTwoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            playerTwoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -213),
            
            // Player one victories label constraints
            victoriesLabelPlayerOne.centerXAnchor.constraint(equalTo: centerXAnchor),
            victoriesLabelPlayerOne.topAnchor.constraint(equalTo: playerOneImageView.bottomAnchor, constant: 10),
            
            // Player one loses label constraints
            loseLabelPlayerOne.centerXAnchor.constraint(equalTo: centerXAnchor),
            loseLabelPlayerOne.topAnchor.constraint(equalTo: victoriesLabelPlayerOne.bottomAnchor, constant: 2),
            
            // Player two victories label constraints
            victoriesLabelPlayerTwo.centerXAnchor.constraint(equalTo: centerXAnchor),
            victoriesLabelPlayerTwo.topAnchor.constraint(equalTo: playerTwoImageView.bottomAnchor, constant: 10),
            
            // Player two loses label constraints
            loseLabelPlayerTwo.centerXAnchor.constraint(equalTo: centerXAnchor),
            loseLabelPlayerTwo.topAnchor.constraint(equalTo: victoriesLabelPlayerTwo.bottomAnchor, constant: 2),
        ])
    }
    
    // MARK: - Setup Views
    func setViews() {
        [
            backgroundImageView,
            vsLabel,
            getReadyLabel,
            playerOneImageView,
            playerTwoImageView,
            victoriesLabelPlayerOne,
            loseLabelPlayerOne,
            victoriesLabelPlayerTwo,
            loseLabelPlayerTwo
        ].forEach { addSubview($0) }

    }
    
    func fillLoadingData(data: [PlayerLoadingData]) {
        let playerOneData = data[0]
        let playerTwoData = data[1]
        
        playerOneImageView.image = playerOneData.image
        victoriesLabelPlayerOne.attributedText = makeVictoriesText(count: playerOneData.win)
        loseLabelPlayerOne.attributedText = makeLosesText(count: playerOneData.lose)
        
        playerTwoImageView.image = playerTwoData.image
        victoriesLabelPlayerTwo.attributedText = makeVictoriesText(count: playerTwoData.win)
        loseLabelPlayerTwo.attributedText = makeLosesText(count: playerTwoData.lose)
        
    }
}

extension LoadScreenView {
    private func makeVictoriesText(count: Int) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(
            string: "\(count) ",
            attributes: [
                NSAttributedString.Key.font : RubikFont.Bold.size(of: 20),
                NSAttributedString.Key.foregroundColor : UIColor.CustomColors.pastelYellowText
            ]
        )
        attributedText.append(NSAttributedString(
            string: "Victories/",
            attributes: [
                NSAttributedString.Key.font : RubikFont.Bold.size(of: 20),
                NSAttributedString.Key.foregroundColor : UIColor.white
            ])
        )
        
        return attributedText
    }
    
    private func makeLosesText(count: Int) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(
            string: "\(count) ",
            attributes: [
                NSAttributedString.Key.font : RubikFont.Bold.size(of: 20),
                NSAttributedString.Key.foregroundColor : UIColor.CustomColors.darkYellowPinkText
            ]
        )
        attributedText.append(NSAttributedString(
            string: "Lose",
            attributes: [
                NSAttributedString.Key.font : RubikFont.Bold.size(of: 20),
                NSAttributedString.Key.foregroundColor : UIColor.white
            ])
        )
        
        return attributedText
    }
}
