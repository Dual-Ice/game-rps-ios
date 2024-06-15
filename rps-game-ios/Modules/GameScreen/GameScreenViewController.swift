//
//  GameScreenViewController.swift
//  rps-game-ios
//
//  Created by nikita on 12.06.24.
//

import UIKit

enum PlayerSide {
    case top
    case bottom
}

final class GameScreenViewController: UIViewController {
    
    private let gameScreenView = GameScreenView()
    private var gameService: GameService
    
    private var leftTime: Int!
    private let gameTime = 30
    
    private var selectedActionButton: UIButton?
    
    override func loadView() {
        view = gameScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameScreenView.delegate = self
        gameService.view = self
        TimeManager.shared.delegate = self
        gameScreenView.setPlayersAvatars(avatars: gameService.getPlayersAvatars())
        setupNavigationBar()
        // play background music
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        gameService.reset()
        startGame()
    }
    
    init(gameService: GameService) {
        self.gameService = gameService

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GameScreenViewController: GameScreenViewDelegate {
    func actionButtonPressed(_ sender: UIButton) {
        gameService.play(playerBottomMove: Move(rawValue: sender.tag)!)
        sender.tintColor = UIColor.CustomColors.pastelYellowText
        selectedActionButton = sender
        switchStateForActionButtons(false)
        TimeManager.shared.stop()
        // play button music
    }
}


//MARK: - Privater Methods
private extension GameScreenViewController {
    @objc func pauseGame() {
        if TimeManager.shared.isRun() {
            TimeManager.shared.stop()
            navigationItem.rightBarButtonItem?.tintColor = UIColor.CustomColors.pastelYellowText
            switchStateForActionButtons(false)
            return
        }
        navigationItem.rightBarButtonItem?.tintColor = UIColor.CustomColors.customBlack
        startGame()
    }
    
    func switchStateForActionButtons(_ state: Bool) {
        gameScreenView.rockButton.isUserInteractionEnabled = state
        gameScreenView.paperButton.isUserInteractionEnabled = state
        gameScreenView.scissorsButton.isUserInteractionEnabled = state
    }
    
    func setPoint(_ point: Int, for player: PlayerSide) {
        switch player {
        case .top:
            gameScreenView.topScoreProgressView.progress = Float(point) * 0.40
        case .bottom:
            gameScreenView.bottomScoreProgressView.progress = Float(point) * 0.40
        }
    }
    
    func setCentralLabel(_ text: String) {
        gameScreenView.centralLabel.text = text
    }
    
    func startGame() {
        switchStateForActionButtons(true)
        selectedActionButton?.tintColor = .white
        resetHands()
        resetTimer()
        
        TimeManager.shared.start()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
           self?.setCentralLabel("")
        }
    }
    
    private func resetHands() {
        gameScreenView.topHandImageView.image = UIImage.CustomImage.femaleHandImage
        gameScreenView.bottomHandImageView.image = UIImage.CustomImage.maleHandImage
    }
    
    private func resetTimer() {
        leftTime = gameTime
        gameScreenView.timerLabel.text = "0:\(gameTime)"
        gameScreenView.timerProgressView.progress = Float(1)
    }
}

// MARK: - Setup UI
private extension GameScreenViewController {
    func setupNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
        let navigationBarAppearance = UINavigationBarAppearance()
        
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.CustomColors.customBlack]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .pause,
            target: self,
            action: #selector(pauseGame)
        )
                
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.tintColor = .CustomColors.customBlack
        
        title = "Игра"
    }
    

    @objc private func backButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension GameScreenViewController: GameServiceViewProtocol {
    func updateScore(score: Int, side: PlayerSide) {
        setPoint(score, for: side)
    }
    
    func endGame(winnerImage: UIImage, playerOneWins: Int, playerTwoWins: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            // stop background music
            let fightResultVC = FightResultViewController(winnerImage: winnerImage, playerOneWins: playerOneWins, playerTwoWins: playerTwoWins)
            self?.navigationController?.pushViewController(fightResultVC, animated: true)
        }
    }
    
    func showPlayersMoves(playerTopMove: Move, playerBottomMove: Move) {
        gameScreenView.topHandImageView.image = gameService.getMoveImage(move: playerTopMove, position: .top)
        gameScreenView.bottomHandImageView.image = gameService.getMoveImage(move: playerBottomMove, position: .bottom)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.startGame()
        }
    }
    
    func showDraw() {
        setCentralLabel("DRAW")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.startGame()
        }
    }
}

extension GameScreenViewController: TimeManagerDelegate {
    func timerTick() {
        leftTime -= 1
        gameScreenView.timerLabel.text = "0:\(leftTime ?? 0)"
        gameScreenView.timerProgressView.progress = Float(leftTime ?? 0) / Float(gameTime)
        if leftTime == 0 {
            setCentralLabel("YOU LOSE") //game mechanics
            TimeManager.shared.stop()
            gameService.playerTwoLose()
            startGame()
        }
    }
}



//#if DEBUG
//import SwiftUI
//
//struct GameScreenViewControllerProvider: PreviewProvider {
//    static var previews: some View {
//        Group {
//            UINavigationController(rootViewController: GameScreenViewController()).previw()
//        }
//    }
//}
//#endif
