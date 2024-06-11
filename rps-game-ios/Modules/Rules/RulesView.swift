//
//  RulesView.swift
//  rps-game-ios
//
//  Created by  Maksim Stogniy on 09.06.2024.
//

import UIKit

final class RulesView: UIView {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let cellIdentifier = "RulesCell"
    
    private let rules = [
            ("Игра проводится между игроком и компьютером.", nil),
            ("Жесты:", nil),
            ("Кулак > Ножницы", UIImage(named: "rules")),
            ("Бумага > Кулак", UIImage(named: "rules")),
            ("Ножницы > Бумага", UIImage(named: "rules")),
            ("У игрока есть 30 сек. для выбора жеста.", nil),
            ("Игра ведётся до трёх побед одного из участников.", nil),
            ("За каждую победу игрок получает 500 баллов, которые можно посмотреть на доске лидеров.", nil)
        ]
    
    private var title: UILabel = {
        let label = UILabel()
        label.text = "Rules"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
    
    func setViews() {
        backgroundColor = .white
        [
            title,
            tableView
        ].forEach { addSubview($0) }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RulesTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
    }
    
    func layoutViews() {
//        если убрать коментарий бедет черный экран
//        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

extension RulesView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rules.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier , for: indexPath) as? RulesTableViewCell else { return UITableViewCell() }
        
        let rule = rules[indexPath.row]
        cell.configureCell(number: indexPath.row + 1, description: rule.0, icon: rule.1)
        return cell
    }
    
    
}
