//
//  RulesViewController.swift
//  rps-game-ios
//
//  Created by  Maksim Stogniy on 09.06.2024.
//

import UIKit

final class RulesViewController: UIViewController {
    
    private let rulesView = RulesView()
    
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
    override func loadView() {
        view = rulesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rulesView.setDelegates(self)
    }
    
    private func createAttributedText(for string: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string)
            
        let shadow = NSShadow()
        shadow.shadowColor = UIColor(white: 0, alpha: 0.3) // Легкий серый цвет
        shadow.shadowOffset = CGSize(width: 1, height: 3) // Легкое смещение
        shadow.shadowBlurRadius = 5.0 // Небольшое размытие
        
        attributedString.addAttribute(.shadow, value: shadow, range: NSRange(location: 0, length: string.count))
            
        if string.contains("500 баллов") {
            if let range = string.range(of: "500 баллов") {
                let nsRange = NSRange(range, in: string)
                attributedString.addAttribute(.foregroundColor, value: UIColor.CustomColors.darkBlueCircle, range: nsRange)
            }
        }
        
        return attributedString
    }
}

extension RulesViewController: RulesViewDelegate {
    
    func didTapGoBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension RulesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rule = rules[indexPath.row]
        let cellIdentifier: String
        
        if indexPath.row == 0 || indexPath.row == 1 {
            cellIdentifier = RulesTableViewCell.identifier
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RulesTableViewCell else { return UITableViewCell() }
            cell.configureCell(number: indexPath.row + 1, description: createAttributedText(for: rule.0))
            cell.backgroundColor = UIColor(red: 245/255.0, green: 247/255.0, blue: 251/255.0, alpha: 1.0)
            cell.selectionStyle = .none
            return cell
        } else if (2...4).contains(indexPath.row) {
            cellIdentifier = ActionCell.identifier
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ActionCell else { return UITableViewCell() }
            cell.configureCell(description: createAttributedText(for: rule.0), icon: rule.1)
            cell.backgroundColor = UIColor(red: 245/255.0, green: 247/255.0, blue: 251/255.0, alpha: 1.0)
            cell.selectionStyle = .none
            return cell
        } else {
            cellIdentifier = RulesTableViewCell.identifier
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RulesTableViewCell else { return UITableViewCell() }
            cell.configureCell(number: indexPath.row - 2, description: createAttributedText(for: rule.0))
            cell.backgroundColor = UIColor(red: 245/255.0, green: 247/255.0, blue: 251/255.0, alpha: 1.0)
            cell.selectionStyle = .none
            return cell
        }
    }
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension // Автоматическая высота для всех ячеек
    }
}
