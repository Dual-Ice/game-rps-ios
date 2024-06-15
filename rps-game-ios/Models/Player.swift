//
//  Player.swift
//  rps-game-ios
//
//  Created by  Maksim Stogniy on 13.06.2024.
//
import UIKit

struct Player: Codable {
    var name: String
    var score: Int
    var roundWin: Int
    var gameWin: Int
    var gameLose: Int
    var avatarName: String

    var avatar: UIImage {
        return UIImage(named: avatarName)!
    }
    // Конструктор с параметрами по умолчанию
    init(name: String = "Player", score: Int = 0, roundWin: Int = 0, gameWin: Int = 0, gameLose: Int = 0, avatarName: String) {
        self.name = name
        self.score = score
        self.roundWin = roundWin
        self.gameWin = gameWin
        self.gameLose = gameLose
        self.avatarName = avatarName
    }
}
