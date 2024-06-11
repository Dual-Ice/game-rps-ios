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

#if DEBUG
struct ViewControllerProvider: PreviewProvider {
	static var previews: some View {
		Group {
			FightResultViewController().previw()
		}
	}
}

extension UIViewController {
	struct Preview: UIViewControllerRepresentable {
		let viewController: UIViewController
		
		func makeUIViewController(context: Context) -> some UIViewController {
			viewController
		}
		
		func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
	}
	
	func previw() -> some View {
		Preview(viewController: self).edgesIgnoringSafeArea(.all)
	}
}
#endif
