//
//  LeaderViewFactory.swift
//  rps-game-ios
//
//  Created by Дмитрий Лубов on 15.06.2024.
//

import UIKit

final class LeaderViewFactory {

	static func makeLeaderView(number: Int, player: PlayerLoadingData) -> UIView {
		let view = LeaderView()

		view.number = "\(number)"
		view.image = player.image
		view.name = player.name
		view.match = "\(player.score)"
		view.rate = String(format: "%.0f", player.winRate) + "%"
		view.layer.cornerRadius = 20

		switch number {
		case 0:
			view.setTheme(.yellow)
		case 1:
			view.setTheme(.gray)
		case 2:
			view.setTheme(.brown)
		default:
			view.setTheme(.base)
		}

		view.translatesAutoresizingMaskIntoConstraints = false

		return view
	}
}
