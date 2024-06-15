//
//  LeaderBoardViewController.swift
//  rps-game-ios
//
//  Created by Дмитрий Лубов on 14.06.2024.
//

import UIKit
#if DEBUG
import SwiftUI
#endif

final class LeaderBoardViewController: UIViewController {
	
	// MARK: - Outlets
	
	// MARK: - Public properties

	// MARK: - Dependencies
	
	// MARK: - Private properties
	
	private lazy var leaderBoardView = LeaderBoardView(delegate: self)
	private let gameService: GameService
	
	private var player: PlayerLoadingData?
	private var leaderList: [PlayerLoadingData]?
	
	// MARK: - Initialization

	init(gameService: GameService) {
		self.gameService = gameService
		player = gameService.getBottomPlayer()
		leaderList = gameService.getLeaderList()
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Lifecycle
	
	override func loadView() {
		view = leaderBoardView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		updatePlayerImage()
		updatePlayerName()
		leaderBoardView.fillLeaderList(leaderList?.sorted { $0.score > $1.score } ?? [])
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		leaderBoardView.layout()
	}
	
	// MARK: - Public methods
	
	// MARK: - Private methods
	
	private func updatePlayerImage() {
		leaderBoardView.setPlayerImage(player?.image ?? UIImage.playerOne)
	}
	
	private func updatePlayerName() {
		leaderBoardView.setPlayerName(player?.name ?? "Player 1")
	}
}

// MARK: - ILeaderBoardViewDelegate

extension LeaderBoardViewController: ILeaderBoardViewDelegate {

	/// Выбрать картинку игрока
	func chooseImage() {
		print("player image")
	}

	/// Изменить имя игрока
	func editName() {
		print("player name")
	}
}

// MARK: - Setup UI

private extension LeaderBoardViewController {
	
	func setupUI() {
		title = "Leaderboard"
		navigationController?.navigationBar.prefersLargeTitles = false
		navigationController?.navigationBar.titleTextAttributes = [.font: RubikFont.Regular.size(of: 25)]
		leaderBoardView.setupUI()
	}
}

#if DEBUG
struct LeaderBoardViewControllerProvider: PreviewProvider {
	static var previews: some View {
		Group {
			UINavigationController(rootViewController: LeaderBoardViewController(gameService: GameService())).preview()
		}
	}
}
#endif
