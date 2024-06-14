//
//  GameService.swift
//  rps-game-ios
//
//  Created by  Maksim Stogniy on 13.06.2024.
//

import UIKit

enum Move: Int {
    case rock = 1
    case paper = 2
    case scissors = 3
}

enum RoundResult {
    case win
    case lose
    case draw
}

protocol GameServiceViewProtocol: AnyObject {
    func endGame(winnerImage: UIImage, playerOneWins: Int, playerTwoWins: Int)
    func showPlayersMoves(playerOneMove: Move, playerTwoMove: Move)
    func showDraw()
}

struct PlayerLoadingData {
    let image: UIImage
    let win: Int
    let lose: Int
}

class GameService {
    
    weak var view: GameServiceViewProtocol!
    
    private var playerOne: Player
    private var playerTwo: Player
    
    init () {
        playerOne = Player(
            name: "player 1",
            avatarName: "playerOne"
        )
        playerTwo = Player(
            name: "player 2",
            avatarName: "playerTwo"
        )
        
        loadPlayersData()
    }
    
    func play(playerOneMove: Move) {
        let playerTwoMove = getPlayerRandomMove()
        let roundResult = getRoundResult(playerOneMove: playerOneMove, playerTwoMove: playerTwoMove)
        // wait 1 second
        view.showPlayersMoves(playerOneMove: playerOneMove, playerTwoMove: playerTwoMove)

        switch roundResult {
            case .win:
                updatePlayerStats(winner: &playerOne, loser: &playerTwo)
            case .lose:
                updatePlayerStats(winner: &playerTwo, loser: &playerOne)
            case .draw:
                view.showDraw()
        }
    }
    
    func reset() {
        playerOne.roundWin = 0
        playerTwo.roundWin = 0
    }
    
    func getPlayersLoadingData() -> [PlayerLoadingData] {
        return [
            PlayerLoadingData(image: playerOne.avatar, win: playerOne.gameWin, lose: playerOne.gameLose),
            PlayerLoadingData(image: playerTwo.avatar, win: playerTwo.gameWin, lose: playerTwo.gameLose)
        ]
    }
    
    // MARK: Private methods
    private func getPlayerRandomMove() -> Move {
        let moves: [Move] = [.rock, .paper, .scissors]
        return moves[Int.random(in: 0..<moves.count)]
    }
    
    private func getRoundResult(playerOneMove: Move, playerTwoMove: Move) -> RoundResult {
        switch (playerOneMove, playerTwoMove) {
        case (let x, let y) where x == y:
            return .draw
        case (.rock, .scissors), (.scissors, .paper), (.paper, .rock):
            return .win
        default:
            return .lose
        }
    }
    
    private func updatePlayerStats(winner: inout Player, loser: inout Player) {
        winner.roundWin += 1
        
        if winner.roundWin == 3 {
            winner.score += 500
            winner.gameWin += 1
            loser.gameLose += 1
            view.endGame(winnerImage: winner.avatar, playerOneWins: playerOne.roundWin, playerTwoWins: playerTwo.roundWin)
            savePlayersData()
        }
    }
    
    private func loadPlayersData() {
        let decoder = JSONDecoder()
        
        if let playerOneData = UserDefaults.standard.data(forKey: "playerOne"),
           let playerTwoData = UserDefaults.standard.data(forKey: "playerTwo") {
            if let loadedPlayerOne = try? decoder.decode(Player.self, from: playerOneData),
               let loadedPlayerTwo = try? decoder.decode(Player.self, from: playerTwoData) {
                playerOne = loadedPlayerOne
                playerTwo = loadedPlayerTwo
            }
        }
    }
    
    private func savePlayersData() {
        let encoder = JSONEncoder()
        if let encodedPlayerOne = try? encoder.encode(playerOne),
           let encodedPlayerTwo = try? encoder.encode(playerTwo) {
            UserDefaults.standard.set(encodedPlayerOne, forKey: "playerOne")
            UserDefaults.standard.set(encodedPlayerTwo, forKey: "playerTwo")
        }
    }
}
