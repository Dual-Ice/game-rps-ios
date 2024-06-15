//
//  Settings.swift
//  rps-game-ios
//
//  Created by Alexander Bokhulenkov on 15.06.2024.
//

import UIKit

struct Settings: Codable {
    var time: Int
    var music: String
    var is2PlayersGame: Bool
    
    init(time: Int = 30, music: String = "defaults", is2PlayersGame: Bool = false) {
        self.time = time
        self.music = music
        self.is2PlayersGame = is2PlayersGame
    }
}



//при загрузке экрана настроек доставал бы ее из userdefaults или если ее нет - создавал соответственно новую со значениями по умолчанию
//Далее при измении любого из параметров сохранял бы ее обратно в userdefaults либо сохранял перед тем как контроллер исчезнет
//Далее когда экран с игрой загрузится - берем эту модель из UD или создаем дефолтную и пользуемся
//И все это можно завернуть в класс GameSettings чтобы он все эти действия делал


