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
    func getSettingsLoad() {
        defaultSettings.time
    }
    
//    сохранение (принимает модель)

    
}



//Далее при измении любого из параметров сохранял бы ее обратно в userdefaults либо сохранял перед тем как контроллер исчезнет
//Далее когда экран с игрой загрузится - берем эту модель из UD или создаем дефолтную и пользуемся
