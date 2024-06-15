//
//  LeaderViewCell.swift
//  rps-game-ios
//
//  Created by Дмитрий Лубов on 15.06.2024.
//

import UIKit

final class LeaderViewCell: UITableViewCell {
    
    private var leaderView: LeaderView?

	static let Identifier = "LeaderViewCell"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        leaderView?.number = nil
        leaderView?.image = nil
        leaderView?.name = nil
        leaderView?.match = nil
        leaderView?.rate = nil
        leaderView?.resetValues()
    }
	
	func configure(by indexPath: IndexPath, with player: LeaderBoardPlayer) {
        leaderView = LeaderViewFactory.makeLeaderView(number: indexPath.row + 4, player: player)
		addSubview(leaderView!)
        leaderView?.heightAnchor.constraint(equalToConstant: 65).isActive = true
	}
}
