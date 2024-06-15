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
        
        settingsScreen.delegate = self
        settingsScreen.getMusicButton().delegate = self
    }
}

extension SettingsViewController: SettingsViewDelegate, CustomMusicButtonDelegate {
    func customMusicButton(_ button: CustomMusicButton, didSelectMusic music: String) {
        print("Music - \(music)")
    }
    
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    
}
