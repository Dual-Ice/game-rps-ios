//
//  RulesView.swift
//  rps-game-ios
//
//  Created by  Maksim Stogniy on 09.06.2024.
//

import UIKit

protocol RulesViewDelegate: AnyObject {
    func didTapGoBackButton()
}

protocol setTableViewDelegate: UITableViewDelegate, UITableViewDataSource {
    
}


final class RulesView: UIView {
    
    private let returnToStartSrceen: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "backButton"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var delegate: RulesViewDelegate?
    weak var tableViewDelegate: setTableViewDelegate?
    
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    let cellIdentifier = "RulesCell"
    
    let rules = [
        ("Игра проводится между игроком и компьютером.", nil),
        ("Жесты:", nil),
        ("Кулак > Ножницы", UIImage(named: "stoneRules")),
        ("Бумага > Кулак", UIImage(named: "paperRules")),
        ("Ножницы > Бумага", UIImage(named: "scissorsRules")),
        ("У игрока есть 30 сек. для выбора жеста.", nil),
        ("Игра ведётся до трёх побед одного из участников.", nil),
        ("За каждую победу игрок получает 500 баллов, которые можно посмотреть на доске лидеров.", nil)
    ]
    
    private var title: UILabel = {
        let label = LabelFactory.makeScreenLabel(text: "Rules")
        return label
    }()
    //    MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
        returnToStartSrceen.addTarget(self, action: #selector(toStartScreenView), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
        layoutViews()
        returnToStartSrceen.addTarget(self, action: #selector(toStartScreenView), for: .touchUpInside)
    }
    
    @objc func toStartScreenView() {
        delegate?.didTapGoBackButton()
    }
    
    func setViews() {
        backgroundColor = UIColor(red: 245/255.0, green: 247/255.0, blue: 251/255.0, alpha: 1.0)
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 245/255.0, green: 247/255.0, blue: 251/255.0, alpha: 1.0)
        tableView.backgroundView = backgroundView
        
        [
            returnToStartSrceen,
            title,
            tableView
        ].forEach { addSubview($0) }
    
        
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.register(RulesTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    //    MARK: - Constraints
    
    func layoutViews() {
        
        NSLayoutConstraint.activate([
            //            title constraints
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            //            table constraints
            tableView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            //            return button constraints
            returnToStartSrceen.widthAnchor.constraint(equalToConstant: 11),
            returnToStartSrceen.heightAnchor.constraint(equalToConstant: 19),
            returnToStartSrceen.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            returnToStartSrceen.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30)
        ])
    }
}
