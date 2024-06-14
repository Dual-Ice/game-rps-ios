//
//  SettingsScreenViewController.swift
//  rps-game-ios
//
//  Created by Alexander on 12.06.24.
//

import UIKit

class SettingsViewController: UIViewController {

    private let settingsScreen = SettingsView()
    
    override func loadView() {
        view = settingsScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
