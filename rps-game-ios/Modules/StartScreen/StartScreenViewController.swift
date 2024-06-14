//
//  StartScreenViewController.swift
//  rps-game-ios
//
//  Created by Alexander Bokhulenkov on 10.06.2024.
//

import UIKit

final class StartScreenViewController: UIViewController {
    
    private let startScreenView = StartScreenView()
    private let gameService = GameService()
    
    override func loadView() {
        view = startScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startScreenView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func didTapRulesButton() {
        let secondVC = RulesViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
}

extension StartScreenViewController: StartScreenViewDelegate {
    func didTapStartButton() {
        
        let loadingVC = LoadScreenViewController(gameService: gameService)
        navigationController?.pushViewController(loadingVC, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let gameVC = GameScreenViewController(gameService: self.gameService)
            self.navigationController?.pushViewController(gameVC, animated: true)
        }
    }
    
    func didTapResultButton() {
        print("result")
    }
    
    func didTapSettingsButton() {
        print("settings")
    }
}
