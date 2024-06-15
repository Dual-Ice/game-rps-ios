//
//  CustomMusicButton.swift
//  rps-game-ios
//
//  Created by Alexander on 14.06.24.
//

import UIKit

protocol CustomMusicButtonDelegate: AnyObject {
    func customMusicButton(_ button: CustomMusicButton, didSelectMusic music: String)
}

final class CustomMusicButton: UIButton {
    
    private let label = UILabel()
    private let iconView = UIImageView()
    private let secondLabel = UILabel()
    
    private let dropdownTableView = UITableView()
    private var isDropdownVisible = false
    private let dropdownItem = ["Мелодия 1", "Мелодия 2"]
    
    weak var delegate: CustomMusicButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        layoutViews()
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addViews()
        layoutViews()
        configure()
    }
    
}

private extension CustomMusicButton {
    func addViews() {
        addSubview(label)
        addSubview(iconView)
        addSubview(secondLabel)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            iconView.widthAnchor.constraint(equalToConstant: 23),
            
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            secondLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            secondLabel.trailingAnchor.constraint(equalTo: iconView.leadingAnchor)
        ])
    }
    
    func configure() {
        
        backgroundColor = UIColor(red: 241/255, green: 170/255, blue: 131/255, alpha: 1)
        layer.cornerRadius = 10
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Фоновая музыка"
        label.textColor = .white
        label.font = RubikFont.Bold.size(of: 16)
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.image = UIImage(systemName: "chevron.right")
        iconView.tintColor = .white
        
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.text = "Мелодия 1"
        secondLabel.textColor = .white
        secondLabel.font = RubikFont.Light.size(of: 14)
        
        setupDropdown()
        addTarget(self, action: #selector(toggleDropdown), for: .touchUpInside)
    }
    
    func setupDropdown() {
        
        dropdownTableView.translatesAutoresizingMaskIntoConstraints = false
        dropdownTableView.dataSource = self
        dropdownTableView.delegate = self
        dropdownTableView.isHidden = true
        dropdownTableView.layer.cornerRadius = 10
        dropdownTableView.layer.borderWidth = 1
        dropdownTableView.layer.borderColor = UIColor.lightGray.cgColor
        dropdownTableView.isScrollEnabled = true
        dropdownTableView.alwaysBounceVertical = true
        
        dropdownTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DropdownCell")
        
        
    }
    
    @objc func toggleDropdown() {
        guard let superview = superview else { return }
        
        if isDropdownVisible {
            dropdownTableView.removeFromSuperview()
        } else {
            superview.addSubview(dropdownTableView)
            
            NSLayoutConstraint.activate([
                dropdownTableView.topAnchor.constraint(equalTo: bottomAnchor),
                dropdownTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                dropdownTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                dropdownTableView.heightAnchor.constraint(equalToConstant: 90)
            ])
        }
        
        isDropdownVisible.toggle()
        dropdownTableView.isHidden = !isDropdownVisible
    }
}
    
    
extension CustomMusicButton: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dropdownItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DropdownCell", for: indexPath)
        cell.textLabel?.text = dropdownItem[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMusic = dropdownItem[indexPath.row]
        secondLabel.text = selectedMusic
        isDropdownVisible = false
        dropdownTableView.isHidden = true
        delegate?.customMusicButton(self, didSelectMusic: selectedMusic)
    }
    
}

