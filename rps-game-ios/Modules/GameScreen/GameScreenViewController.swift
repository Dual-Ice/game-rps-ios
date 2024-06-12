//
//  GameScreenViewController.swift
//  rps-game-ios
//
//  Created by nikita on 12.06.24.
//

import UIKit

final class GameScreenViewController: UIViewController, GameScreenViewDelegate {
    
    private let gameScreenView = GameScreenView()
    
    override func loadView() {
        //super.loadView() //?
        view = gameScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameScreenView.delegate = self
        
        setupNavigationBar()
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
