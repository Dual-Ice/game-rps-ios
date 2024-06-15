//
//  NameModalView.swift
//  rps-game-ios
//
//  Created by  Maksim Stogniy on 15.06.2024.
//
import UIKit

protocol NameModalViewDelegate: AnyObject {
    func submitName(_ name: String)
}

class NameModalView: UIView {
    
    weak var delegate: NameModalViewDelegate?
    // MARK: - Properties
    
    private let overlayView = UIView()
    private let formView = UIView()
    
    private let titleLabel: UILabel = {
        let element = UILabel()
        element.text = "Введите имя игрока"
        element.font = RubikFont.Regular.size(of: 14)
        element.textColor = UIColor.CustomColors.grayLeaderText
        element.translatesAutoresizingMaskIntoConstraints = false

        return element
    }()
    
    private let textField: UITextField = {
        let element = UITextField()
        element.layer.cornerRadius = 20
        element.layer.masksToBounds = true
        element.layer.borderWidth = 1
        element.layer.borderColor = UIColor.systemGray5.cgColor
        element.font = RubikFont.Bold.size(of: 16)
        element.backgroundColor = UIColor(named:"grayLightest")
        element.translatesAutoresizingMaskIntoConstraints = false
        element.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: element.frame.height))
        element.leftViewMode = .always
        return element
    }()
    
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
    
    var okAction: (() -> Void)?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setText(_ text: String) {
        textField.text = text
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        setupOverlayView()
        setupFormView()
        setupConstraints()
    }
    
    private func setupOverlayView() {
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
        
        formView.addSubview(titleLabel)
        
        textField.placeholder = "Enter new name"
        textField.borderStyle = .roundedRect
        formView.addSubview(textField)
        
        okButton.addTarget(self, action: #selector(didTapOk), for: .touchUpInside)
        formView.addSubview(okButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        formView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            formView.centerXAnchor.constraint(equalTo: centerXAnchor),
            formView.centerYAnchor.constraint(equalTo: centerYAnchor),
            formView.widthAnchor.constraint(equalToConstant: 300),
            formView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: formView.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: 16),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            textField.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant: -16),
            textField.widthAnchor.constraint(equalToConstant: 275),
            textField.heightAnchor.constraint(equalToConstant: 45),
            
            okButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 40),
            okButton.centerXAnchor.constraint(equalTo: formView.centerXAnchor),
            okButton.bottomAnchor.constraint(equalTo: formView.bottomAnchor, constant: -20),
            okButton.widthAnchor.constraint(equalToConstant: 135),
            okButton.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
    
    // MARK: - Actions
    
    @objc private func didTapOk() {
        delegate?.submitName(textField.text ?? "Super Player")
        removeFromSuperview()
    }
}

