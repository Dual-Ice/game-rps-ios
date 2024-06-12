//
//  StartScreenView.swift
//  rps-game-ios
//
//  Created by Alexander Bokhulenkov on 11.06.2024.
//
protocol StartScreenViewDelegate: AnyObject {
    func didTapRulesButton()
    func didTapStartButton()
    func didTapResultButton()
    func didTapSettingsButton()
}

import UIKit

final class StartScreenView: UIView {
    
    weak var delegate: StartScreenViewDelegate?
    
    private let startLabel: UILabel = {
        let label = LabelFactory.makeStartScreenLabel(text: "EPIC RPS")
        return label
    }()
    
    private let startButton: UIButton = {
        let button = ButtonFactory.make3DButtonWithText(text: "Start")
        return button
    }()
    
    private let resultsButton: UIButton = {
        let button = ButtonFactory.make3DButtonWithText(text: "Results")
        return button
    }()
    
    private let rulesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "rules"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "settings"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let rightHandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rightHand")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let leftHandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "leftHand")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
//    MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutView()
        targetAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
        layoutView()
        targetAction()
    }
    
    //    MARK: - Selectors
    
    @objc func rulesVC() {
        delegate?.didTapRulesButton()
    }
    
    @objc func startGame() {
        delegate?.didTapStartButton()
    }
    
    @objc func resultsGame() {
        delegate?.didTapResultButton()
    }
    
    @objc func settingsVC() {
        delegate?.didTapSettingsButton()
    }
    
    //    MARK: - Helpers

     func setViews() {
        backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.968627451, blue: 0.9843137255, alpha: 1)
        [
            rulesButton,
            startButton,
            resultsButton,
            startLabel,
            settingsButton,
            rightHandImageView,
            leftHandImageView
        ].forEach { addSubview($0) }
    }
    
//    таргет для кнопок
    func targetAction() {
        rulesButton.addTarget(self, action: #selector(rulesVC), for: .touchUpInside)
        resultsButton.addTarget(self, action: #selector(resultsGame), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(settingsVC), for: .touchUpInside)
    }
    
    func layoutView() {
        NSLayoutConstraint.activate([
            
            //  rulesButton constraints
            rulesButton.widthAnchor.constraint(equalToConstant: 35),
            rulesButton.heightAnchor.constraint(equalToConstant: 35),
            rulesButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            rulesButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -21),
            
            //            startLabel constraints
            startLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            startLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            //            startButton constraints
            startButton.widthAnchor.constraint(equalToConstant: 196),
            startButton.heightAnchor.constraint(equalToConstant: 53),
            startButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 90.5),
            startButton.bottomAnchor.constraint(equalTo: resultsButton.topAnchor, constant: -11),
            
            //            resultsButton constraints
            resultsButton.widthAnchor.constraint(equalToConstant: 196),
            resultsButton.heightAnchor.constraint(equalToConstant: 53),
            resultsButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 90.5),
            resultsButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            //            settingsButton constraints
            settingsButton.widthAnchor.constraint(equalToConstant: 35),
            settingsButton.heightAnchor.constraint(equalToConstant: 35),
            settingsButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            settingsButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 21),
            
            //            rightHand ImageView consraints
            rightHandImageView.widthAnchor.constraint(equalToConstant: 200),
            rightHandImageView.heightAnchor.constraint(equalToConstant: 83),
            rightHandImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            rightHandImageView.bottomAnchor.constraint(equalTo: startLabel.topAnchor, constant: -20),
            
            //            leftHand ImageView consraints
            leftHandImageView.widthAnchor.constraint(equalToConstant: 200),
            leftHandImageView.heightAnchor.constraint(equalToConstant: 83),
            leftHandImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            leftHandImageView.topAnchor.constraint(equalTo: startLabel.bottomAnchor, constant: 20)
        ])
    }
}
