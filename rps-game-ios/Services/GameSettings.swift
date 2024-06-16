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
    
    private init () {
        defaultSettings = Settings(
            time: 30,
            music: "background1",
            is2PlayersGame: false
        )
    }

    func getSettingsLoad() -> Settings {
        let decoder = JSONDecoder()
        
        if let gameSettings = UserDefaults.standard.data(forKey: "gameSettings"),
           let settings = try? decoder.decode(Settings.self, from: gameSettings) {
            return settings
        }
        
        return defaultSettings
    }
    
    func saveSettings(_ settings: Settings) {
        let encoder = JSONEncoder()
        if let encodedGameSettings = try? encoder.encode(settings) {
            UserDefaults.standard.set(encodedGameSettings, forKey: "gameSettings")
        }
    }
}


