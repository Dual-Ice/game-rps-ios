//
//  RulesView.swift
//  rps-game-ios
//
//  Created by  Maksim Stogniy on 09.06.2024.
//

import UIKit

final class RulesView: UIView {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    let cellIdentifier = "RulesCell"
    
    private let rules = [
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
        backgroundColor = UIColor(red: 245/255.0, green: 247/255.0, blue: 251/255.0, alpha: 1.0)
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 245/255.0, green: 247/255.0, blue: 251/255.0, alpha: 1.0)
        tableView.backgroundView = backgroundView
        
        [
            title,
            tableView
        ].forEach { addSubview($0) }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RulesTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func layoutViews() {
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension RulesView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier , for: indexPath) as? RulesTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = UIColor(red: 245/255.0, green: 247/255.0, blue: 251/255.0, alpha: 1.0)
        cell.selectionStyle = .none
        
        let rule = rules[indexPath.row]
        
        if indexPath.row == 0 || indexPath.row == 1 {
            cell.configureCell(number: indexPath.row + 1, description: rule.0)
        } else if (2...4).contains(indexPath.row)  {
            cell.configureCellWithImage(description: rule.0, icon: rule.1)
            cell.iconImageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 30).isActive = true
            cell.descriptionLabel.leadingAnchor.constraint(equalTo: cell.iconImageView.trailingAnchor, constant: 10).isActive = true
        } else {
            cell.configureCell(number: indexPath.row - 2, description: rule.0)
        }
        return cell
    }

}
