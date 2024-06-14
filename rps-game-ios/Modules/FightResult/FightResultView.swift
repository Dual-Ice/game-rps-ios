//
//  FightResultView.swift
//  rps-game-ios
//
//  Created by Дмитрий Лубов on 11.06.2024.
//

import UIKit
#if DEBUG
import SwiftUI
#endif

/// Протокол делегата.
protocol IFightResultViewDelegate: AnyObject {
	/// Домой.
	func homeGame()
	/// Повторить.
	func repeatGame()
}

final class FightResultView: UIView {

	// MARK: - Dependencies

	private weak var delegate: IFightResultViewDelegate?

	// MARK: - Private properties

	private lazy var backgroundImage: UIImageView = makeImageView()
	private lazy var mainStack: UIStackView = makeStack()

	private lazy var circleView: UIView = makeView()
	private lazy var characterImage: UIImageView = makeImageView()

	private lazy var labelStack: UIStackView = makeStack()
	private let resultLabel: UILabel = LabelFactory.makeSmallLabel(text: "")
	private lazy var scoreLabel: UILabel = makeLabel()

	private lazy var buttonStack: UIStackView = makeStack()
	private let homeButton: UIButton = ButtonFactory.make3DButtonWithIcon(imageName: "house-icon")
	private let repeatButton: UIButton = ButtonFactory.make3DButtonWithIcon(imageName: "repeat-icon")
	
	// MARK: - Initialization

	init(delegate: IFightResultViewDelegate) {
		super.init(frame: .zero)
		self.delegate = delegate
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Public methods

	/// Заглушка для экрана.
	func setStubState() {
		backgroundImage.image = ResultGame.lose.backgroundImage
		characterImage.image = UIImage.CustomImage.playerOneImage
		resultLabel.text = ResultGame.lose.text
		resultLabel.textColor = .black
		scoreLabel.text = "1 - 3"
	}

	/// Устанавливает тему для победы.
	/// - Parameters:
	///   - player: картинка игрока
	///   - score: счет игрока
	func setWinTheme(for player: UIImage, with score: String) {
		backgroundImage.image = ResultGame.win.backgroundImage
		characterImage.image = player
		resultLabel.text = ResultGame.win.text
		scoreLabel.text = score
	}

	/// Устанавливает тему для поражения.
	/// - Parameters:
	///   - player: картинка игрока
	///   - score: счет игрока
	func setLoseTheme(for player: UIImage, with score: String) {
		backgroundImage.image = ResultGame.lose.backgroundImage
		characterImage.image = player
		resultLabel.text = ResultGame.lose.text
		resultLabel.textColor = .black
		scoreLabel.text = score
	}
}

// MARK: - Setup UI

extension FightResultView {
	
	/// Установка UI элементов.
	func setupUI() {
		addSubviews()
		addActions()

		setupMainStack()
		setupLabelStack()
		setupResultLabel()
		setupButtonStack()
	}
	
	private func makeImageView() -> UIImageView {
		let element = UIImageView()
		
		element.contentMode = .scaleAspectFill
		element.translatesAutoresizingMaskIntoConstraints = false
		
		return element
	}

	private func makeStack() -> UIStackView {
		let element = UIStackView()

		element.translatesAutoresizingMaskIntoConstraints = false

		return element
	}

	private func makeView() -> UIView {
		let element = UIView()

		element.backgroundColor = UIColor.CustomColors.darkBlueCircle
		element.layer.cornerRadius = 88
		element.translatesAutoresizingMaskIntoConstraints = false

		return element
	}

	private func makeLabel() -> UILabel {
		let element = UILabel()

		element.font = RubikFont.Medium.size(of: 41)
		element.textColor = .white
		element.textAlignment = .center
		element.translatesAutoresizingMaskIntoConstraints = false

		return element
	}
}

// MARK: - Layout UI

extension FightResultView {

	/// Настройка констреинтов.
	func layout() {
		NSLayoutConstraint.activate([
			backgroundImage.topAnchor.constraint(equalTo: topAnchor),
			backgroundImage.widthAnchor.constraint(equalTo: widthAnchor),
			backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
			backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),

			mainStack.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
			mainStack.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
			mainStack.widthAnchor.constraint(equalToConstant: 176),

			circleView.heightAnchor.constraint(equalTo: mainStack.widthAnchor),

			characterImage.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
			characterImage.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
			characterImage.widthAnchor.constraint(equalToConstant: 67),
			characterImage.heightAnchor.constraint(equalToConstant: 78),

			buttonStack.heightAnchor.constraint(equalToConstant: 52),
			homeButton.widthAnchor.constraint(equalToConstant: 67),
			repeatButton.widthAnchor.constraint(equalToConstant: 67)
		])
	}
}

// MARK: - Actions

private extension FightResultView {

	@objc
	func homeButtonTapped(_ sender: UIButton) {
		delegate?.homeGame()
	}

	@objc
	func repeatButtonTapped(_ sender: UIButton) {
		delegate?.repeatGame()
	}
}

// MARK: - Setting UI

private extension FightResultView {

	func addSubviews() {
		addSubview(backgroundImage)
		addSubview(mainStack)

		mainStack.addArrangedSubview(circleView)
		mainStack.addArrangedSubview(labelStack)
		mainStack.addArrangedSubview(buttonStack)

		circleView.addSubview(characterImage)

		labelStack.addArrangedSubview(resultLabel)
		labelStack.addArrangedSubview(scoreLabel)

		buttonStack.addArrangedSubview(homeButton)
		buttonStack.addArrangedSubview(repeatButton)
	}

	func addActions() {
		homeButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
		repeatButton.addTarget(self, action: #selector(repeatButtonTapped), for: .touchUpInside)
	}

	func setupResultLabel() {
		resultLabel.textAlignment = .center
	}

	func setupMainStack() {
		mainStack.spacing = 30
		mainStack.axis = .vertical
	}

	func setupLabelStack() {
		labelStack.axis = .vertical
	}

	func setupButtonStack() {
		buttonStack.distribution = .equalSpacing
	}
}

// MARK: - enum Result game

private extension FightResultView {

	enum ResultGame {

		case win
		case lose

		var text: String {
			switch self {
			case .win:
				"You Win"
			case .lose:
				"You Lose"
			}
		}

		var backgroundImage: UIImage? {
			switch self {
			case .win:
				UIImage.CustomImage.winBackgroundImage
			case .lose:
				UIImage.CustomImage.loseBackgroundImage
			}
		}
	}
}

#if DEBUG
import SwiftUI
#endif

#if DEBUG
struct FightResultViewProvider: PreviewProvider {
	static var previews: some View {
		Group {
			FightResultViewController().preview()
		}
	}
}
#endif
