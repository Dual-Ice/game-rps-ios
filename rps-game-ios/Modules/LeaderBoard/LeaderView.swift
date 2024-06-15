//
//  LeaderView.swift
//  rps-game-ios
//
//  Created by Дмитрий Лубов on 14.06.2024.
//

import UIKit
#if DEBUG
import SwiftUI
#endif

final class LeaderView: UIView {

	// MARK: - Public properties

	/// Номер в списке лидеров
	var number: String?
	/// Картинка игрока
	var image: UIImage?
	/// Имя игрока
	var name: String?
	/// Баллы игрока
	var match: String?
	/// Процент побед
	var rate: String?

	// MARK: - Private properties

	private lazy var mainStack = makeStackView()

	private lazy var numberLabel = makeLabel()
	private lazy var playerImage = makeImageView()
	private lazy var nameLabel = makeLabel()
	private lazy var matchLabel = makeLabel()
	private lazy var rateLabel = makeLabel()
	private lazy var circleImage = makeImageView()
	
	// MARK: - Initialization

	init() {
		super.init(frame: .zero)
		setupUI()
		layout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public methods

	/// Устанавливаем тему для view
	/// - Parameter theme: тема view
	func setTheme(_ theme: Theme) {
		numberLabel.text = number
		playerImage.image = image
		nameLabel.text = name
		matchLabel.text = match
		rateLabel.text = rate
		
		backgroundColor = theme.background
		numberLabel.textColor = theme.background ?? UIColor.CustomColors.grayText
		nameLabel.textColor = theme.nameColor
		matchLabel.textColor = theme.textColor
		rateLabel.textColor = theme.textColor
		circleImage.image = theme.circle
	}
}

// MARK: - Theme View

extension LeaderView {
	
	/// Тема view
	enum Theme {

		case yellow
		case gray
		case brown
		case base
		
		/// Цвет фона
		var background: UIColor? {
			switch self {
			case .yellow:
				UIColor.CustomColors.yellowLeader
			case .gray:
				UIColor.CustomColors.grayLeader
			case .brown:
				UIColor.CustomColors.brownLeader
			case .base:
				nil
			}
		}
		
		/// Цвет имени
		var nameColor: UIColor {
			switch self {
			case .yellow:
				UIColor.CustomColors.yellowLeaderText
			case .gray:
				UIColor.CustomColors.grayLeaderText
			case .brown:
				UIColor.CustomColors.brownLeaderText
			case .base:
				UIColor.CustomColors.grayText
			}
		}
		
		/// Цвет основного текста
		var textColor: UIColor {
			switch self {
			case .yellow, .gray, .brown:
				UIColor.CustomColors.darkGrayText
			case .base:
				UIColor.CustomColors.grayText
			}
		}
		
		/// Картинка цветного кружка
		var circle: UIImage? {
			switch self {
			case .yellow:
				UIImage.CustomImage.yellowCircle
			case .gray:
				UIImage.CustomImage.grayCircle
			case .brown:
				UIImage.CustomImage.brownCircle
			case .base:
				nil
			}
		}
	}
}

// MARK: - Setup UI

private extension LeaderView {

	func setupUI() {
		addSubviews()
		setupFonts()
	}

	private func makeStackView() -> UIStackView {
		let element = UIStackView()

		element.translatesAutoresizingMaskIntoConstraints = false

		return element
	}

	private func makeImageView() -> UIImageView {
		let element = UIImageView()

		element.contentMode = .scaleAspectFit
		element.translatesAutoresizingMaskIntoConstraints = false

		return element
	}

	private func makeLabel() -> UILabel {
		let element = UILabel()
		element.translatesAutoresizingMaskIntoConstraints = false
		return element
	}
}

// MARK: - Setting UI

private extension LeaderView {

	func addSubviews() {
		addSubview(mainStack)
		addSubview(circleImage)

		mainStack.addArrangedSubview(numberLabel)
		mainStack.addArrangedSubview(playerImage)
		mainStack.addArrangedSubview(nameLabel)
		mainStack.addArrangedSubview(UILabel())
		mainStack.addArrangedSubview(matchLabel)
		mainStack.addArrangedSubview(rateLabel)
	}

	func setupFonts() {
		numberLabel.font = RubikFont.Bold.size(of: 9)
		nameLabel.font = RubikFont.Bold.size(of: 14)
		matchLabel.font = RubikFont.Bold.size(of: 13)
		rateLabel.font = RubikFont.Medium.size(of: 18)
	}
}

// MARK: - Layout UI

private extension LeaderView {

	func layout() {
		NSLayoutConstraint.activate([
			mainStack.centerYAnchor.constraint(equalTo: centerYAnchor),
			mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
			mainStack.heightAnchor.constraint(equalToConstant: 35),

			playerImage.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor, constant: 16),
			playerImage.widthAnchor.constraint(equalTo: mainStack.heightAnchor),
			
			nameLabel.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor, constant: 66),
			nameLabel.widthAnchor.constraint(equalToConstant: 130),
			
			matchLabel.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor, constant: 212),
			rateLabel.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor, constant: 277),

			circleImage.centerYAnchor.constraint(equalTo: centerYAnchor),
			circleImage.centerXAnchor.constraint(equalTo: trailingAnchor),
			circleImage.widthAnchor.constraint(equalToConstant: 19),
			circleImage.heightAnchor.constraint(equalToConstant: 19),
		])
	}
}

#if DEBUG
struct LeaderViewProvider: PreviewProvider {
	static var previews: some View {
		Group {
			UINavigationController(rootViewController: LeaderBoardViewController(gameService: GameService())).preview()
		}
	}
}
#endif
