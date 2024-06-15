//
//  SettingsScreenViewController.swift
//  rps-game-ios
//
//  Created by Alexander on 12.06.24.
//

import UIKit

class SettingsViewController: UIViewController {

    private let settingsScreen = SettingsView()
    private var settings: Settings?
    override func loadView() {
        view = settingsScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settings = GameSettings.shared.getSettingsLoad()
        settingsScreen.delegate = self
        settingsScreen.getMusicButton().delegate = self
        settingsScreen.fillSettings(settings!)
    }
}

extension SettingsViewController: SettingsViewDelegate, CustomMusicButtonDelegate {
    func changeTime(time: Int) {
        settings?.time = time
        GameSettings.shared.saveSettings(settings!)
    }
    
    func setTwoPlayersGame(state: Bool) {
        settings?.is2PlayersGame = state
        GameSettings.shared.saveSettings(settings!)
    }
    
    func customMusicButton(_ button: CustomMusicButton, didSelectMusic music: String) {
        settings?.music = music
        GameSettings.shared.saveSettings(settings!)
    }
    
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    
}
