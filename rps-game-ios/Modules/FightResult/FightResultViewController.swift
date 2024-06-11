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

	// MARK: - Private properties

	private lazy var fightResultView = FightResultView(delegate: self)

	// MARK: - Lifecycle

	override func loadView() {
		view = fightResultView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		fightResultView.setupUI()
		fightResultView.setStubState()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		fightResultView.layout()
	}
}

// MARK: - IFightResultViewControllerDelegate

extension FightResultViewController: IFightResultViewDelegate {
	func homeGame() {
		print("Go home")
	}
	
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
