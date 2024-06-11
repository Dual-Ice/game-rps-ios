//
//  LoadScreenView.swift
//  rps-game-ios
//
//  Created by Alexander on 11.06.24.
//

import UIKit

final class LoadScreenView: UIView {
    // MARK: - Private properties
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "winBackground")
        return imageView
    }()
    
    private lazy var playerOneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "playerOne")
        return imageView
    }()
    
    private lazy var playerTwoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "playerTwo")
        return imageView
    }()
    
    private let vsLabel = LabelFactory.makeLargeLabel(text: "VS")
    private let getReadyLabel = LabelFactory.makeSmallLabel(text: "Get ready...")
    
    
    //MARK: Initializers
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
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            vsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            vsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            getReadyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            getReadyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -56),
            
            playerOneImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            playerOneImageView.topAnchor.constraint(equalTo: topAnchor, constant: 153),
            
            playerTwoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            playerTwoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -213)
        ])
    }
    
    // MARK: - Setup Views
    func setViews() {
        [
            backgroundImageView,
            vsLabel,
            getReadyLabel,
            playerOneImageView,
            playerTwoImageView
        ].forEach { addSubview($0) }

    }
}
