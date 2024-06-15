//
//  GameSettings.swift
//  rps-game-ios
//
//  Created by Alexander Bokhulenkov on 15.06.2024.
//

import UIKit

class GameSettings {
    
    static let shared = GameSettings()
    
    private var defaultSettings: Settings
    
    init () {
        defaultSettings = Settings(time: 30, music: "background1", is2PlayersGame: false)
    }

//    загрузка (отдает модель либо генерирует стандартную и ее отдает)
    func getSettingsLoad() -> Settings {
        let decoder = JSONDecoder()
        
        if let gameSettings = UserDefaults.standard.data(forKey: "gameSettings"),
           let settings = try? decoder.decode(Settings.self, from: gameSettings) {
            return settings
        }
           return defaultSettings
    }
    
    func saveSettings() {
        let encoder = JSONEncoder()
        if let encoderGameSettings = try? encoder.encode(defaultSettings) {
            UserDefaults.standard.set(encoderGameSettings, forKey: "gameSettings")
        }
    }
}


