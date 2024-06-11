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
}

import UIKit

final class StartScreenView: UIView {
    
    weak var delegate: StartScreenViewDelegate?
    
    private let startLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 138, height: 36))
        label.text = "EPIC RPS"
        label.textColor = #colorLiteral(red: 0.9395877719, green: 0.6671555638, blue: 0.5318560004, alpha: 1)
        label.font = UIFont(name: "Rubik", size: 30)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("START", for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik", size: 16)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(#colorLiteral(red: 0.7684260011, green: 0.5614033341, blue: 0.4590145946, alpha: 1), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.7647058824, blue: 0.6, alpha: 1)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let resultsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("RESULTS", for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik", size: 16)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(#colorLiteral(red: 0.7684260011, green: 0.5614033341, blue: 0.4590145946, alpha: 1), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.7647058824, blue: 0.6, alpha: 1)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let rulesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "rules"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        delegate?.didTapRulesButton()
    }
    
    //    MARK: - Helpers

     func setViews() {
        backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.968627451, blue: 0.9843137255, alpha: 1)
        [
            rulesButton, startButton, resultsButton, startLabel
        ].forEach { addSubview($0) }
        
//        применение тени к тексту
        startLabel.shadowStartLabel("EPIC RPS")
    }
    
//    таргет для кнопок
    func targetAction() {
        rulesButton.addTarget(self, action: #selector(rulesVC), for: .touchUpInside)
        resultsButton.addTarget(self, action: #selector(resultsGame), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
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
            startButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 622),
            startButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 90.5),
            
            //            resultsButton constraints
            resultsButton.widthAnchor.constraint(equalToConstant: 196),
            resultsButton.heightAnchor.constraint(equalToConstant: 53),
            resultsButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 11),
            resultsButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 90.5),
        ])
    }
    
}

// MARK: - Extensions

extension UILabel {
    func shadowStartLabel(_ string: String) {
        // Создание атрибутированного текста
        let attributedText = NSMutableAttributedString(string: string)
        let customFont = UIFont(name: "Rubik-Bold", size: 30) ??  UIFont.boldSystemFont(ofSize: 30)
        attributedText.addAttribute(.font, value: customFont, range: NSRange(location: 0, length: attributedText.length))
        
        // Установка тени
        let shadow = NSShadow()
        shadow.shadowColor = #colorLiteral(red: 0.9192885756, green: 0.6009836197, blue: 0.4597279429, alpha: 1)
        shadow.shadowOffset = CGSize(width: 2, height: 2)
        shadow.shadowBlurRadius = 1
        attributedText.addAttribute(.shadow, value: shadow, range: NSRange(location: 0, length: attributedText.length))
        
        // Применение атрибутированного текста к UILabel
        self.attributedText = attributedText
    }
}
