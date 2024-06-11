//
//  FightResultView.swift
//  rps-game-ios
//
//  Created by Дмитрий Лубов on 11.06.2024.
//

import UIKit

final class FightResultView: UIView {
	
	// MARK: - Public properties

	
	/// Делегат fight result view controller
	weak var delegate: IFightResultViewControllerDelegate?

	/// Картинка игрока
	var playerImage: UIImage?

	/// Текст победы или поражения
	///
	/// Пример:
	/// ```swift
	/// resultText = "You Win"
	/// // Или
	/// resultText = "You Lose"
	/// ```
	var resultText: String?

	/// Цвет текста поражения
	///
	/// По умолчанию используется цвет текста победы:
	/// ```swift
	/// UIColor(red: 255/255.0, green: 178/255.0, blue: 76/255.0, alpha: 1.0)
	/// ```
	/// 
	/// Пример:
	/// ```swift
	/// colorResultText = nil // если победа
	/// // Или
	/// colorResultText = .black // если поражение
	/// ```
	var colorResultText: UIColor?

	/// Счет игрока
	///
	/// Пример:
	/// ```swift
	/// scoreText = "3 - 1"
	/// ```
	var scoreText: String?

	/// Фон view
	var backgroundImage: UIImage?

	// MARK: - Private properties

	private lazy var backgroundImageView: UIImageView = makeImageView()
	private lazy var mainStack: UIStackView = makeStack()

	private lazy var circleView: UIView = makeView()
	private lazy var characterImage: UIImageView = makeImageView()

	private lazy var labelStack: UIStackView = makeStack()
	private lazy var resultLabel: UILabel = LabelFactory.makeSmallLabel(text: resultText ?? "")
	private lazy var scoreLabel: UILabel = makeLabel()

	private lazy var buttonStack: UIStackView = makeStack()
	private lazy var homeButton: UIButton = ButtonFactory.make3DButtonWithIcon(imageName: "house-icon")
	private lazy var repeatButton: UIButton = ButtonFactory.make3DButtonWithIcon(imageName: "repeat-icon")
}

// MARK: - Setup UI

extension FightResultView {
	
	/// Установка UI элементов
	func setupUI() {
		addSubviews()
		addActions()

		setupBackgroundImageView()
		setupMainStack()
		setupCharacterImage()
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

		element.backgroundColor = UIColor(red: 43 / 255.0, green: 40 / 255.0, blue: 112 / 255.0, alpha: 1)
		element.layer.cornerRadius = 88
		element.translatesAutoresizingMaskIntoConstraints = false

		return element
	}

	private func makeLabel() -> UILabel {
		let element = UILabel()

		element.text = scoreText
		element.font = .systemFont(ofSize: 41, weight: .bold)
		element.textColor = .white
		element.textAlignment = .center
		element.translatesAutoresizingMaskIntoConstraints = false

		return element
	}
}

// MARK: - Layout UI

extension FightResultView {

	/// Настройка констреинтов
	func layout() {
		NSLayoutConstraint.activate([
			backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
			backgroundImageView.widthAnchor.constraint(equalTo: widthAnchor),
			backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
			backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),

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
		addSubview(backgroundImageView)
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

	func setupBackgroundImageView() {
		backgroundImageView.image = backgroundImage
	}

	func setupResultLabel() {
		resultLabel.textAlignment = .center

		if let colorResultText {
			resultLabel.textColor = colorResultText
		}
	}

	func setupMainStack() {
		mainStack.spacing = 30
		mainStack.axis = .vertical
	}

	func setupCharacterImage() {
		characterImage.image = playerImage
	}

	func setupLabelStack() {
		labelStack.axis = .vertical
	}

	func setupButtonStack() {
		buttonStack.distribution = .equalSpacing
	}
}
