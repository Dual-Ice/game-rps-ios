//
//  FightResultViewController.swift
//  rps-game-ios
//
//  Created by Дмитрий Лубов on 11.06.2024.
//

import UIKit
#if DEBUG
import SwiftUI
#endif

final class FightResultViewController: UIViewController {

	// MARK: - Public properties
	
	/// Картинка игрока.
	var player: UIImage?
	/// Количество побед.
	var numberOfWin: Int?
	/// Количество поражений.
	var numberOfLose: Int?

	// MARK: - Private properties

	private lazy var fightResultView = FightResultView(delegate: self)

	// MARK: - Lifecycle

	override func loadView() {
		view = fightResultView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		fightResultView.setupUI()
		showResultGame()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		fightResultView.layout()
	}

	// MARK: - Private methods

	private func showResultGame() {
		guard
			let player,
			let numberOfWin,
			let numberOfLose
		else {
			fightResultView.setStubState()
			return
		}

		let score = "\(numberOfWin) - \(numberOfLose)"

		if numberOfWin > numberOfLose {
			fightResultView.setWinTheme(for: player, with: score)
		} else {
			fightResultView.setLoseTheme(for: player, with: score)
		}
	}
}

// MARK: - IFightResultViewDelegate

extension FightResultViewController: IFightResultViewDelegate {

	/// Возврат на главный экран.
	func homeGame() {
		print("Go home")
	}

	/// Начинает игру заново.
	func repeatGame() {
		print("Repeat")
	}
}

#if DEBUG
struct FightResultViewControllerProvider: PreviewProvider {
	static var previews: some View {
		Group {
			FightResultViewController().previw()
		}
	}
}
#endif
