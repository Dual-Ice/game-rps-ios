//
//  AvatarModalView.swift
//  rps-game-ios
//
//  Created by  Maksim Stogniy on 15.06.2024.
//

import UIKit

protocol AvatarModalViewDelegate: AnyObject {
    func submitAvatar(_ avatarIndex: Int)
}

class AvatarModalView: UIView {
    
    weak var delegate: AvatarModalViewDelegate?
    
    private var selectedAvatarIndex: Int = 1
    private let formView = UIView()
    private let buttonsContainer = UIView()
    
    private let okButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("OK", for: .normal)
        button.titleLabel?.font = RubikFont.Bold.size(of: 16)
        button.setTitleColor(UIColor(named: "lightOrange"), for: .normal)
        button.backgroundColor = UIColor(named: "orangeShadowButtonColor")
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let buttonSize: CGFloat = 60
    private let spacing: CGFloat = 12
    
    private var avatarButtons: [UIButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelectedAvatar(_ index: Int) {
        selectedAvatarIndex = index
        let selectedIndex = index - 1 // Преобразовать индекс от 1-8 к 0-7
        guard selectedIndex >= 0 && selectedIndex < avatarButtons.count else { return }
        
        let selectedButton = avatarButtons[selectedIndex]
        selectedButton.backgroundColor = UIColor(named: "darkGreenTimelineColor")
        
        let checkmark = UIImageView(image: UIImage(named: "checkmark"))
        checkmark.tag = 999 // Уникальный тег для галочки
        checkmark.frame = CGRect(x: buttonSize - 15, y: buttonSize - 15, width: 10, height: 8)
        checkmark.tag = 100
        selectedButton.addSubview(checkmark)
    }
    
    private func setupUI() {
        setupOverlayView()
        setupFormView()
        setupButtonsContainer()
        setupButtons()
        setupConstraints()
        
        okButton.addTarget(self, action: #selector(didTapOk), for: .touchUpInside)
    }
    
    private func setupOverlayView() {
        let overlayView = UIView()
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        overlayView.frame = UIScreen.main.bounds
        overlayView.isUserInteractionEnabled = true
        addSubview(overlayView)
    }
    
    private func setupFormView() {
        formView.backgroundColor = .white
        formView.layer.cornerRadius = 23
        formView.layer.masksToBounds = true
        addSubview(formView)
    }
    
    private func setupButtonsContainer() {
        buttonsContainer.layer.borderWidth = 1
        buttonsContainer.layer.borderColor = UIColor(named: "grayLeaderColor")?.cgColor
        buttonsContainer.layer.cornerRadius = 28
        buttonsContainer.backgroundColor = UIColor(named:"grayLightest")
        buttonsContainer.translatesAutoresizingMaskIntoConstraints = false
        formView.addSubview(okButton)
        formView.addSubview(buttonsContainer)
    }
    
    private func setupButtons() {
        for i in 1...8 {
            let button = createAvatarButton(for: i)
            avatarButtons.append(button)
            buttonsContainer.addSubview(button)
        }
        print(avatarButtons.count)
    }
    
    private func createAvatarButton(for index: Int) -> UIButton {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(named: "grayLeaderColor")
        button.setImage(UIImage(named: "character-small-\(index)"), for: .normal)
        button.addTarget(self, action: #selector(didTapAvatarButton(_:)), for: .touchUpInside)
        button.tag = index
        return button
    }
    
    private func setupConstraints() {
        formView.translatesAutoresizingMaskIntoConstraints = false
        buttonsContainer.translatesAutoresizingMaskIntoConstraints = false
        let rows = 2
        let columns = 4
        
        for (index, button) in avatarButtons.enumerated() {
            let row = index / columns
            let col = index % columns
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: buttonSize),
                button.heightAnchor.constraint(equalToConstant: buttonSize),
                button.topAnchor.constraint(equalTo: buttonsContainer.topAnchor, constant: CGFloat(row) * (buttonSize + spacing) + 30),
                button.leadingAnchor.constraint(equalTo: buttonsContainer.leadingAnchor, constant: CGFloat(col) * (buttonSize + spacing) + 10)
            ])
        }
        
        NSLayoutConstraint.activate([
            formView.centerXAnchor.constraint(equalTo: centerXAnchor),
            formView.centerYAnchor.constraint(equalTo: centerYAnchor),
            formView.widthAnchor.constraint(equalToConstant: 315),
            formView.heightAnchor.constraint(equalToConstant: 330),
            
            buttonsContainer.heightAnchor.constraint(equalToConstant: 190),
            buttonsContainer.widthAnchor.constraint(equalToConstant: 290),
            buttonsContainer.topAnchor.constraint(equalTo: formView.topAnchor, constant: 30),
            buttonsContainer.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: 30),
            buttonsContainer.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant: -10),
            buttonsContainer.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: 10),
            
            okButton.topAnchor.constraint(equalTo: buttonsContainer.bottomAnchor, constant: 40),
            okButton.centerXAnchor.constraint(equalTo: formView.centerXAnchor),
            okButton.bottomAnchor.constraint(equalTo: formView.bottomAnchor, constant: -35),
            okButton.widthAnchor.constraint(equalToConstant: 135),
            okButton.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
    
    
    // MARK: - Actions
    
    @objc private func didTapOk() {
        delegate?.submitAvatar(selectedAvatarIndex)
        removeFromSuperview()
    }

    @objc private func didTapAvatarButton(_ sender: UIButton) {
        for button in avatarButtons {
            button.backgroundColor = UIColor(named: "grayLeaderColor")
            if let checkmark = button.subviews.first(where: { $0.tag == 100 }) {
                checkmark.removeFromSuperview()
            }
        }
        
        sender.backgroundColor = UIColor(named: "darkGreenTimelineColor")
        let checkmark = UIImageView(image: UIImage(named: "checkmark"))
        checkmark.frame = CGRect(x: buttonSize - 20, y: buttonSize - 15, width: 10, height: 8)
        checkmark.tag = 100
        sender.addSubview(checkmark)
        
        selectedAvatarIndex = sender.tag
    }
}
