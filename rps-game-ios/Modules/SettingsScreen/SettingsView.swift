//
//  SettingsScreen.swift
//  rps-game-ios
//
//  Created by Alexander on 12.06.24.
//

import UIKit

class SettingsView: UIView {
    // MARK: - Private properties
    //Title label
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = RubikFont.Regular.size(of: 25)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Game time label
    private lazy var gameTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "ВРЕМЯ ИГРЫ"
        label.font = RubikFont.Regular.size(of: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Background view for time button
    private lazy var backgroundViewForGameTime: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 2
        
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //StackView for time button
    private lazy var gameTimeStackView: UIStackView = {
        let button30 = UIButton(type: .system)
        let attributedTitle30 = NSAttributedString(
            string: "30 сек.",
            attributes: [
                .font : RubikFont.Bold.size(of: 16),
                .foregroundColor : UIColor.white
            ]
        )
        button30.setAttributedTitle(attributedTitle30, for: .normal)
        button30.backgroundColor = UIColor(red: 241/255, green: 170/255, blue: 131/255, alpha: 1)
        button30.layer.cornerRadius = 10
        button30.translatesAutoresizingMaskIntoConstraints = false
        
        let button60 = UIButton(type: .system)
        let attributedTitle60 = NSAttributedString(
            string: "60 сек.",
            attributes: [
                .font : RubikFont.Bold.size(of: 16),
                .foregroundColor : UIColor.white
            ]
        )
        button60.setAttributedTitle(attributedTitle60, for: .normal)
        button60.backgroundColor = UIColor(red: 241/255, green: 170/255, blue: 131/255, alpha: 1)
        button60.layer.cornerRadius = 10
        button60.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [button30, button60])
        stackView.axis = .horizontal
        stackView.spacing = 44
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //Background view for music button
    private let backgroundViewForMusic: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 2
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //StackView for music button and switch
    private lazy var gameMusicStackView: UIStackView = {
        
        let button = CustomMusicButton()
        
        let friendModeView = UIView()
        friendModeView.backgroundColor = UIColor(red: 241/255, green: 170/255, blue: 131/255, alpha: 1)
        friendModeView.layer.cornerRadius = 10
        friendModeView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        let attributedTitleLabel = NSAttributedString(
            string: "Игра с другом",
            attributes: [
                .font : RubikFont.Bold.size(of: 16),
                .foregroundColor : UIColor.white
            ]
        )
        label.attributedText = attributedTitleLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let toggle = UISwitch()
        toggle.isOn = true
        toggle.translatesAutoresizingMaskIntoConstraints = false
        
        friendModeView.addSubview(label)
        friendModeView.addSubview(toggle)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: friendModeView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: friendModeView.leadingAnchor, constant: 10),
            
            toggle.centerYAnchor.constraint(equalTo: friendModeView.centerYAnchor),
            toggle.trailingAnchor.constraint(equalTo: friendModeView.trailingAnchor, constant: -10)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [button, friendModeView])
        stackView.axis = .vertical
        stackView.spacing = 22
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
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
            //Title label
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            
            //Game time label
            gameTimeLabel.topAnchor.constraint(equalTo: backgroundViewForGameTime.topAnchor, constant: 20),
            gameTimeLabel.leadingAnchor.constraint(equalTo: backgroundViewForGameTime.leadingAnchor, constant: 20),
            
            
            //backgroundView for GameTime
            backgroundViewForGameTime.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 86),
            backgroundViewForGameTime.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            backgroundViewForGameTime.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            backgroundViewForGameTime.heightAnchor.constraint(equalToConstant: 130),
            
            //Game time buttons Stack View
            gameTimeStackView.topAnchor.constraint(equalTo: backgroundViewForGameTime.topAnchor, constant: 64),
            gameTimeStackView.leadingAnchor.constraint(equalTo: backgroundViewForGameTime.leadingAnchor, constant: 18),
            gameTimeStackView.trailingAnchor.constraint(equalTo: backgroundViewForGameTime.trailingAnchor, constant: -18),
            gameTimeStackView.bottomAnchor.constraint(equalTo: backgroundViewForGameTime.bottomAnchor, constant: -26),
            
            //Background view for music button
            backgroundViewForMusic.topAnchor.constraint(equalTo: backgroundViewForGameTime.bottomAnchor, constant: 22),
            backgroundViewForMusic.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            backgroundViewForMusic.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            backgroundViewForMusic.heightAnchor.constraint(equalToConstant: 165),
            
            gameMusicStackView.topAnchor.constraint(equalTo: backgroundViewForMusic.topAnchor, constant: 20),
            gameMusicStackView.leadingAnchor.constraint(equalTo: backgroundViewForMusic.leadingAnchor, constant: 18),
            gameMusicStackView.trailingAnchor.constraint(equalTo: backgroundViewForMusic.trailingAnchor, constant: -18),
            gameMusicStackView.bottomAnchor.constraint(equalTo: backgroundViewForMusic.bottomAnchor, constant: -25),
            
        ])
    }
    
    // MARK: - Setup Views
    func setViews() {
        backgroundColor = .white
        
        [
            titleLabel,
            backgroundViewForGameTime,
            backgroundViewForMusic,
        ].forEach { addSubview($0) }
        
        backgroundViewForGameTime.addSubview(gameTimeStackView)
        backgroundViewForGameTime.addSubview(gameTimeLabel)
        
        backgroundViewForMusic.addSubview(gameMusicStackView)
    }
    
}

