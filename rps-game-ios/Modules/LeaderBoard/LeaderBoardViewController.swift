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
	
	/// Картинка игрока.
	var playerImage: UIImage?
	/// Имя игрока
	var playerName: String?
	
	// MARK: - Dependencies
	
	// MARK: - Private properties
	
	private lazy var leaderBoardView = LeaderBoardView(delegate: self)
	
	// MARK: - Initialization
	
	// MARK: - Lifecycle
	
	override func loadView() {
		view = leaderBoardView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		updatePlayerImage()
		updatePlayerName()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		leaderBoardView.layout()
	}
	
	// MARK: - Public methods
	
	// MARK: - Private methods
	
	private func updatePlayerImage() {
		leaderBoardView.setPlayerImage(playerImage ?? UIImage.playerOne)
	}
	
	private func updatePlayerName() {
		leaderBoardView.setPlayerName(playerName ?? "Player 1")
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
			UINavigationController(rootViewController: LeaderBoardViewController()).preview()
		}
	}
}
#endif
