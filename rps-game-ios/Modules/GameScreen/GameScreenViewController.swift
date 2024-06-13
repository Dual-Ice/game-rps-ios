//
//  GameScreenViewController.swift
//  rps-game-ios
//
//  Created by nikita on 12.06.24.
//

import UIKit

final class GameScreenViewController: UIViewController, GameScreenViewDelegate {
    
    private let gameScreenView = GameScreenView()
    private let gameService = GameService()
    
    override func loadView() {
        view = gameScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameScreenView.delegate = self
        gameService.view = self
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gameService.reset()
        // так же сбросить таймер, полоски прогресса, картинки рук
        
    }
}
//MARK: - Privater Methods
private extension GameScreenViewController {
    @objc
    private func pauseGame() {
        
    }
}


//MARK: - Setup UI
private extension GameScreenViewController {
    func setupNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .pause,
            target: self,
            action: #selector(pauseGame)
        )
        
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.CustomColors.customBlack]
        
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.tintColor = .CustomColors.customBlack
        
        title = "Игра"
    }
}

extension GameScreenViewController: GameServiceViewProtocol {
    func endGame(winnerImage: UIImage, playerOneWins: Int, playerTwoWins: Int) {
        let fightResultVC = FightResultViewController(winnerImage: winnerImage, playerOneWins: playerOneWins, playerTwoWins: playerTwoWins)
        navigationController?.pushViewController(fightResultVC, animated: true)
    }
    
    func showPlayersMoves(playerOneMove: Move, playerTwoMove: Move) {
//        <#code#>
    }
    
    func showDraw() {
//        <#code#>
    }
    
    
}


#if DEBUG
import SwiftUI

struct GameScreenViewControllerProvider: PreviewProvider {
    static var previews: some View {
        Group {
            UINavigationController(rootViewController: GameScreenViewController()).previw()
        }
    }
}
#endif
