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
    func showPlayersMoves(playerTopMove: Move, playerBottomMove: Move)
    func showDraw()
    func updateScore(score: Int, side: PlayerSide)
}

struct PlayerLoadingData {
    let image: UIImage
    let win: Int
    let lose: Int

	var name = ""
	var score = 0
	var winRate = 0.0
}

struct LeaderBoardPlayer {
    let name: String
    let avatar: UIImage
    let score: Int
    let rate: Double
}


class GameService {
    
    weak var view: GameServiceViewProtocol!
    
    private var playerTop: Player
    private var playerBottom: Player
    private let queue = DispatchQueue(label: "com.rps-game.queue")
    
    init () {
        playerTop = Player(
            name: "player 1",
            avatarName: "playerOne"
        )
        playerBottom = Player(
            name: "player 2",
            avatarName: "playerTwo"
        )
        
        loadPlayersData()
    }
    
    func play(playerBottomMove: Move) {
        let playerTopMove = getPlayerRandomMove()
        let roundResult = getRoundResult(playerTopMove: playerTopMove, playerBottomMove: playerBottomMove)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
//        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] timer in
            guard let self = self else { return }
            self.view?.showPlayersMoves(playerTopMove: playerTopMove, playerBottomMove: playerBottomMove)

            switch roundResult {
            case .win:
                self.updatePlayerStats(winner: &self.playerBottom, loser: &self.playerTop)
                self.view?.updateScore(score: self.playerBottom.roundWin, side: .bottom)
                self.checkGameEnd(winner: playerBottom, playerTopWins: playerTop.roundWin, playerBottomWins: playerBottom.roundWin)
            case .lose:
                self.updatePlayerStats(winner: &self.playerTop, loser: &self.playerBottom)
                self.view?.updateScore(score: self.playerTop.roundWin, side: .top)
                self.checkGameEnd(winner: playerTop, playerTopWins: playerTop.roundWin, playerBottomWins: playerBottom.roundWin)
            case .draw:
                self.view?.showDraw()
            }
        }
    }
    
    func playerTwoLose() {
        updatePlayerStats(winner: &playerTop, loser: &playerBottom)
        view?.updateScore(score: playerTop.roundWin, side: .top)
    }
    
    func reset() {
        playerTop.roundWin = 0
        playerBottom.roundWin = 0
        view?.updateScore(score: playerTop.roundWin, side: .top)
        view?.updateScore(score: playerBottom.roundWin, side: .bottom)
    }
    
    func getPlayersLoadingData() -> [PlayerLoadingData] {
        return [
            PlayerLoadingData(image: playerTop.avatar, win: playerTop.gameWin, lose: playerTop.gameLose),
            PlayerLoadingData(image: playerBottom.avatar, win: playerBottom.gameWin, lose: playerBottom.gameLose)
        ]
    }

	func getBottomPlayer() -> PlayerLoadingData {
		PlayerLoadingData(
			image: playerBottom.avatar,
			win: playerBottom.gameWin,
			lose: playerBottom.gameLose,
			name: playerBottom.name
		)
	}
    

	func getLeaderList() -> [LeaderBoardPlayer] {
        var players = (1...8).map { _ in generateRandomPlayer() }
        
        [playerTop, playerBottom].forEach {
            players.append(LeaderBoardPlayer(
                name: $0.name,
                avatar: $0.avatar,
                score: $0.score,
                rate:  (Double($0.gameWin) / Double($0.gameWin + $0.gameLose)) * 100
            ))
        }
        
        return players.sorted(by: { $0.score > $1.score })
	}
    
    func getPlayersAvatars() -> [UIImage] {
        return [playerTop.avatar, playerBottom.avatar]
    }
    
    func getMoveImage(move: Move, position: PlayerSide)  -> UIImage {
        if position == .top {
            switch move {
            case .rock:
                return UIImage.CustomImage.rockFemaleHandImage!
            case .paper:
                return UIImage.CustomImage.paperFemaleHandImage!
            case .scissors:
                return UIImage.CustomImage.scissorsFemaleHandImage!
            }
        }
        
        switch move {
        case .rock:
            return UIImage.CustomImage.rockMaleHandImage!
        case .paper:
            return UIImage.CustomImage.paperMaleHandImage!
        case .scissors:
            return UIImage.CustomImage.scissorsMaleHandImage!
        }
        
        
    }
    
    // MARK: Private methods
    
    private func generateRandomPlayer() -> LeaderBoardPlayer {
        let names = ["Alice", "Bob", "Charlie", "David", "Eve", "Frank", "Grace", "Hank", "Ivy", "Jack"]
        let randomName = names.randomElement()!
        let randomAvatarNumber = Int.random(in: 1...8)
        let randomAvatar = UIImage(named: "character-\(randomAvatarNumber)")!
        
        let gameWin = Int.random(in: 4...30)
        let gameLose = Int.random(in: 0...gameWin)
        let score = gameWin * 500
        let rate = (Double(gameWin) / Double(gameWin + gameLose)) * 100
        
        return LeaderBoardPlayer(name: randomName, avatar: randomAvatar, score: score, rate: rate)
    }
    
    private func getPlayerRandomMove() -> Move {
        let moves: [Move] = [.rock, .paper, .scissors]
        return moves[Int.random(in: 0..<moves.count)]
    }
    
    // Returns result for bottom player
    private func getRoundResult(playerTopMove: Move, playerBottomMove: Move) -> RoundResult {
        switch (playerTopMove, playerBottomMove) {
        case (let x, let y) where x == y:
            return .draw
        case (.rock, .scissors), (.scissors, .paper), (.paper, .rock):
            return .lose
        default:
            return .win
        }
    }
    
    private func updatePlayerStats(winner: inout Player, loser: inout Player) {
        winner.roundWin += 1

        if winner.roundWin == 3 {
            winner.score += 500
            winner.gameWin += 1
            loser.gameLose += 1
        }
    }
    
    private func checkGameEnd(winner: Player, playerTopWins: Int, playerBottomWins: Int) {
        if winner.roundWin == 3 {
            DispatchQueue.main.async {
                self.view.endGame(winnerImage: winner.avatar, playerOneWins: playerTopWins, playerTwoWins: playerBottomWins)
                self.savePlayersData()
            }
        }
    }
    
    private func loadPlayersData() {
        let decoder = JSONDecoder()
        
        if let playerOneData = UserDefaults.standard.data(forKey: "playerOne"),
           let playerTwoData = UserDefaults.standard.data(forKey: "playerTwo") {
            if let loadedPlayerOne = try? decoder.decode(Player.self, from: playerOneData),
               let loadedPlayerTwo = try? decoder.decode(Player.self, from: playerTwoData) {
                playerTop = loadedPlayerOne
                playerBottom = loadedPlayerTwo
            }
        }
    }
    
    private func savePlayersData() {
        let encoder = JSONEncoder()
        if let encodedPlayerOne = try? encoder.encode(playerTop),
           let encodedPlayerTwo = try? encoder.encode(playerBottom) {
            UserDefaults.standard.set(encodedPlayerOne, forKey: "playerOne")
            UserDefaults.standard.set(encodedPlayerTwo, forKey: "playerTwo")
        }
    }
}
