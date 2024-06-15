//
//  LeaderViewCell.swift
//  rps-game-ios
//
//  Created by Дмитрий Лубов on 15.06.2024.
//

import UIKit

final class LeaderViewCell: UITableViewCell {

	static let Identifier = "LeaderViewCell"
	
	func configure(by indexPath: IndexPath, with player: PlayerLoadingData) {
		let view = LeaderViewFactory.makeLeaderView(number: indexPath.row + 4, player: player)
		addSubview(view)
		view.heightAnchor.constraint(equalToConstant: 65).isActive = true
	}
}
