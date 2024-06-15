//
//  SettingsScreen.swift
//  rps-game-ios
//
//  Created by Alexander on 12.06.24.
//

import UIKit

protocol SettingsViewDelegate: AnyObject {
    func didTapBackButton()
}

class SettingsView: UIView {
    
    weak var delegate: SettingsViewDelegate?
    // MARK: - Private properties
    
    
    
    private var selectedTime: Int = 30 {
        didSet {
            updateButtonStates()
        }
    }
    
    //Back button
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.CustomImage.arrowLeft, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    
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
    
    private var gameSettings = GameSettings.shared.getSettingsLoad()
    
    // 30 seconds button
    private lazy var button30: UIButton = {
        let button = createGameTimeButton(withTitle: "30 сек.", time: 30)
        return button
    }()
    
    // 60 seconds button
    private lazy var button60: UIButton = {
        let button = createGameTimeButton(withTitle: "60 сек.", time: 60)
        return button
    }()
    
    //StackView for time button
    private lazy var gameTimeStackView: UIStackView = {
        
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
    
    // Music Button
      private lazy var musicButton: CustomMusicButton = {
          let button = CustomMusicButton()
          button.translatesAutoresizingMaskIntoConstraints = false
          return button
      }()
    
    //StackView for music button and switch
    private lazy var gameMusicStackView: UIStackView = {
        
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
        
        let stackView = UIStackView(arrangedSubviews: [musicButton, friendModeView])
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
        updateButtonStates()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
        layoutViews()
        updateButtonStates()
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
            
            backButton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23),
            backButton.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 11)
            
        ])
    }
    
    // MARK: - Setup Views
    private func createGameTimeButton(withTitle title: String, time: Int) -> UIButton {
        let button = UIButton(type: .system)
        let attributedTitle = NSAttributedString(
            string: title,
            attributes: [
                .font : RubikFont.Bold.size(of: 16),
                .foregroundColor : UIColor.white
            ]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.backgroundColor = UIColor(red: 241/255, green: 170/255, blue: 131/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = time
        button.addTarget(self, action: #selector(gameTimeButtonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    private func updateButtonStates() {
        button30.backgroundColor = selectedTime == 30 ? .darkGray : UIColor(red: 241/255, green: 170/255, blue: 131/255, alpha: 1)
        button60.backgroundColor = selectedTime == 60 ? .darkGray : UIColor(red: 241/255, green: 170/255, blue: 131/255, alpha: 1)
    }
    
    @objc private func gameTimeButtonTapped(_ sender: UIButton) {
        selectedTime = sender.tag
    }
    
    func setViews() {
        backgroundColor = .white
        
        [
            titleLabel,
            backgroundViewForGameTime,
            backgroundViewForMusic,
            backButton
        ].forEach { addSubview($0) }
        
        backgroundViewForGameTime.addSubview(gameTimeStackView)
        backgroundViewForGameTime.addSubview(gameTimeLabel)
        
        backgroundViewForMusic.addSubview(gameMusicStackView)
        
    }
    
    //MARK: - Selectors
    
    @objc func backButtonTapped() {
        delegate?.didTapBackButton()
    }
    
    //MARK: - Functions
    func getMusicButton() -> CustomMusicButton {
        return musicButton
    }
    
}
