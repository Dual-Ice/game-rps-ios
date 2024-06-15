//
//  LeaderModel.swift
//  rps-game-ios
//
//  Created by Дмитрий Лубов on 15.06.2024.
//

import UIKit

/// Пространство имен
enum LeaderBoardModel {
	
	/// Модель игрока
	struct Player {
		let image: UIImage
		let name: String
	}
	
	/// Модель игрока из таблицы лидеров
	struct Leader {
		let image: UIImage
		let name: String
		let match: Double
		let rate: Int
	}
}
