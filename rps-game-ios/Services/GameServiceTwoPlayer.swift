//
//  GameServiceTwoPlayer.swift
//  rps-game-ios
//
//  Created by nikita on 16.06.24.
//

import UIKit

class GameServiceTwoPlayer: GameService {
        
    private var playerTop: Player
    private var playerBottom: Player
    
    override init () {
        playerTop = Player(
            name: "player 1",
            avatarName: "playerOne"
        )
        playerBottom = Player(
            name: "player 2",
            avatarName: "character-1"
        )
        
        super.init()
        
        loadPlayersData()
    }
    
    override func play(playerBottomMove: Move) {
        let playerTopMove = getPlayerRandomMove()
        let roundResult = getRoundResult(playerTopMove: playerTopMove, playerBottomMove: playerBottomMove)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            self.view?.showPlayersMoves(playerTopMove: playerTopMove, playerBottomMove: playerBottomMove)

            switch roundResult {
            case .win:
                self.updatePlayerStats(winner: &self.playerBottom, loser: &self.playerTop)
                self.view?.updateScore(score: self.playerBottom.roundWin, side: .bottom)
                self.checkGameEnd(winner: self.playerBottom, playerTopWins: self.playerTop.roundWin, playerBottomWins: self.playerBottom.roundWin)
            case .lose:
                self.updatePlayerStats(winner: &self.playerTop, loser: &self.playerBottom)
                self.view?.updateScore(score: self.playerTop.roundWin, side: .top)
                self.checkGameEnd(winner: self.playerTop, playerTopWins: self.playerTop.roundWin, playerBottomWins: self.playerBottom.roundWin)
            case .draw:
                self.view?.showDraw()
            }
        }
    }
    
    override func playerTopWin() -> Bool {
        playerTop.roundWin == 3
    }
    
    override func playerTwoLose() {
        updatePlayerStats(winner: &playerTop, loser: &playerBottom)
        view?.updateScore(score: playerTop.roundWin, side: .top)
        checkGameEnd(
            winner: playerTop,
            playerTopWins: playerTop.roundWin,
            playerBottomWins: playerBottom.roundWin
        )
    }
    
    override func reset() {
        playerTop.roundWin = 0
        playerBottom.roundWin = 2
        view?.updateScore(score: playerTop.roundWin, side: .top)
        view?.updateScore(score: playerBottom.roundWin, side: .bottom)
    }
    
    override func getPlayersLoadingData() -> [PlayerLoadingData] {
        return [
            PlayerLoadingData(image: playerTop.avatar, win: playerTop.gameWin, lose: playerTop.gameLose),
            PlayerLoadingData(image: playerBottom.avatar, win: playerBottom.gameWin, lose: playerBottom.gameLose)
        ]
    }

    override func getBottomPlayer() -> PlayerData {
        PlayerData(
            image: playerBottom.avatar,
            imageName: playerBottom.avatarName,
            name: playerBottom.name
        )
    }
    

    override func getLeaderList() -> [LeaderBoardPlayer] {
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
    
    override func setBottomPlayerName(_ name: String) {
        playerBottom.name = name
        savePlayersData()
    }
    
    override func setBottomPlayerAvatar(_ name: String) {
        playerBottom.avatarName = name
        savePlayersData()
    }
    
    override func getPlayersAvatars() -> [UIImage] {
        return [playerTop.avatar, playerBottom.avatar]
    }
    
    override func getMoveImage(move: Move, position: PlayerSide)  -> UIImage {
        if position == .top {
            switch move {
            case .rock:
                return UIImage.CustomImage.rockFemaleHandImage!
            case .paper:
                return UIImage.CustomImage.paperFemaleHandImage!
            case .scissors:
                return UIImage.CustomImage.scissorsFemaleHandImage!
            case .select:
                return UIImage.CustomImage.femaleHandImage!
            }
        }
        
        switch move {
        case .rock:
            return UIImage.CustomImage.rockMaleHandImage!
        case .paper:
            return UIImage.CustomImage.paperMaleHandImage!
        case .scissors:
            return UIImage.CustomImage.scissorsMaleHandImage!
        case .select:
            return UIImage.CustomImage.maleHandImage!
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
