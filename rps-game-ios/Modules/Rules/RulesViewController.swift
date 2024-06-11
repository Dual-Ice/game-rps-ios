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
        // Do any additional setup after loading the view.
    }


}
