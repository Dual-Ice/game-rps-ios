//
//  FightResultViewController.swift
//  rps-game-ios
//
//  Created by Дмитрий Лубов on 11.06.2024.
//

import UIKit

protocol IFightResultViewControllerDelegate: AnyObject {
	func homeGame()
	func repeatGame()
}

final class FightResultViewController: UIViewController {

	// MARK: - Private properties

	private let fightResultView = FightResultView()

	// MARK: - Lifecycle

	override func loadView() {
		view = fightResultView

		fightResultView.delegate = self
		fightResultView.playerImage = UIImage(systemName: "person.fill")
		fightResultView.resultText = "You Lose"
		fightResultView.colorResultText = .black
		fightResultView.scoreText = "1 - 3"
		fightResultView.backgroundImage = UIImage(named: "red-background")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		fightResultView.setupUI()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		fightResultView.layout()
	}
}

// MARK: - IFightResultViewControllerDelegate

extension FightResultViewController: IFightResultViewControllerDelegate {
	func homeGame() {
		print("Go home")
	}
	
	func repeatGame() {
		print("Repeat")
	}
}
