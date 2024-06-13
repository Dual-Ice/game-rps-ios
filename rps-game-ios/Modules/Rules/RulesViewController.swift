//
//  RulesViewController.swift
//  rps-game-ios
//
//  Created by  Maksim Stogniy on 09.06.2024.
//

import UIKit

final class RulesViewController: UIViewController {
    
    private let rulesView = RulesView()
    
    override func loadView() {
        view = rulesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rulesView.delegate = self
        rulesView.tableViewDelegate = self
    }
}

extension RulesViewController: RulesViewDelegate {
    
    func didTapGoBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension RulesViewController : setTableViewDelegate {
    
    func start() {}
    
    func tableView2(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rulesView.rules.count
    }
    
    func tableView1(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = rulesView.cellIdentifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier , for: indexPath) as? RulesTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = UIColor(red: 245/255.0, green: 247/255.0, blue: 251/255.0, alpha: 1.0)
        cell.selectionStyle = .none
        
        let rule = rulesView.rules[indexPath.row]
        
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
