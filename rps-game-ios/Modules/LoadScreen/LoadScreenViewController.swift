//
//  LoadScreenViewController.swift
//  rps-game-ios
//
//  Created by Alexander on 11.06.24.
//

import UIKit

class LoadScreenViewController: UIViewController {
    
    private let loadScreenView = LoadScreenView()
    private var gameService: GameService
    
    override func loadView() {
        super.loadView()
        view = loadScreenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadScreenView.fillLoadingData(data: gameService.getPlayersLoadingData())
    }
    
    
    init(gameService: GameService) {
        self.gameService = gameService

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
