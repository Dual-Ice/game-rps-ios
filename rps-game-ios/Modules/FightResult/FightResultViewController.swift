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
	var playerTopWins: Int?
	/// Количество поражений.
	var playerBottomWins: Int?

	// MARK: - Private properties

	private lazy var fightResultView = FightResultView(delegate: self)

    init(winnerImage: UIImage, playerOneWins: Int, playerTwoWins: Int) {
        self.player = winnerImage
        
        self.playerTopWins = playerOneWins
        self.playerBottomWins = playerTwoWins

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

	// MARK: - Private methods

	private func showResultGame() {
		guard
			let player,
			let playerTopWins,
			let playerBottomWins
		else {
			fightResultView.setStubState()
			return
		}

		let score = "\(playerBottomWins) - \(playerTopWins)"

		if playerTopWins < playerBottomWins {
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
        navigationController?.popToRootViewController(animated: true)
	}

	/// Начинает игру заново.
	func repeatGame() {
        navigationController?.popViewController(animated: true)
	}
}

#if DEBUG
struct FightResultViewControllerProvider: PreviewProvider {
	static var previews: some View {
		Group {
            FightResultViewController(
                winnerImage: UIImage.CustomImage.playerOneImage!,
                playerOneWins: 1,
                playerTwoWins: 2
            ).preview()
		}
	}
}
#endif
