//
//  LeaderBoardView.swift
//  rps-game-ios
//
//  Created by Дмитрий Лубов on 14.06.2024.
//

import UIKit
#if DEBUG
import SwiftUI
#endif

/// Протокол делегата.
protocol ILeaderBoardViewDelegate: AnyObject {
	/// Выбрать картинку.
	func chooseImage()
	/// Изменить Имя.
	func editName()
}

final class LeaderBoardView: UIView {
	
	// MARK: - Outlets
	
	// MARK: - Public properties
	
	// MARK: - Dependencies

	private weak var delegate: ILeaderBoardViewDelegate?

	// MARK: - Private properties

	private lazy var backgroundLayer: CAGradientLayer = makeGradientLayer()

	private lazy var playerImage: UIImageView = makeImageView()
	private lazy var playerImageButton: UIButton = makeButton()

	private lazy var playerNameView: UIView = makeView()
	private lazy var playerNameLabel: UILabel = makeLabel()
	private lazy var playerNameButton: UIButton = makeButton()

	// MARK: - Initialization

	init(delegate: ILeaderBoardViewDelegate) {
		super.init(frame: .zero)
		self.delegate = delegate
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle
	
	// MARK: - Public methods

	func setPlayerImage(_ image: UIImage) {
		playerImage.image = image
	}

	func setPlayerName(_ name: String) {
		playerNameLabel.text = name
	}

	// MARK: - Private methods
}

// MARK: - Setup UI

extension LeaderBoardView {

	/// Установка UI элементов.
	func setupUI() {
		addSubviews()
		addAction()

		setupPlayerImage()
	}

	private func makeGradientLayer() -> CAGradientLayer {
		let layer = CAGradientLayer()

		layer.colors = [
			UIColor.CustomColors.whiteGradientColorOne.cgColor,
			UIColor.CustomColors.whiteGradientColorTwo.cgColor
		]
		layer.locations = [0, 1]
		self.layer.insertSublayer(layer, at: 0)

		return layer
	}

	private func makeImageView() -> UIImageView {
		let element = UIImageView()

		element.contentMode = .scaleAspectFill
		element.translatesAutoresizingMaskIntoConstraints = false

		return element
	}

	private func makeView() -> UIView {
		let element = UIView()

		element.backgroundColor = .white
		element.layer.borderWidth = 1
		element.layer.borderColor = UIColor.CustomColors.grayBorder.cgColor
		element.layer.cornerRadius = 23
		element.translatesAutoresizingMaskIntoConstraints = false

		return element
	}

	private func makeLabel() -> UILabel {
		let element = UILabel()

		element.font = RubikFont.Bold.size(of: 16)
		element.textColor = UIColor.CustomColors.grayBlueText
		element.translatesAutoresizingMaskIntoConstraints = false

		return element
	}

	private func makeButton() -> UIButton {
		let element = UIButton()

		element.configuration = .plain()
		element.translatesAutoresizingMaskIntoConstraints = false

		return element
	}
}

// MARK: - Layout UI

extension LeaderBoardView {

	/// Настройка констреинтов.
	func layout() {
		backgroundLayer.frame = frame

		NSLayoutConstraint.activate([
			playerImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			playerImage.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
			playerImage.widthAnchor.constraint(equalToConstant: 46),
			playerImage.heightAnchor.constraint(equalToConstant: 46),

			playerImageButton.topAnchor.constraint(equalTo: playerImage.topAnchor),
			playerImageButton.leadingAnchor.constraint(equalTo: playerImage.leadingAnchor),
			playerImageButton.trailingAnchor.constraint(equalTo: playerImage.trailingAnchor),
			playerImageButton.bottomAnchor.constraint(equalTo: playerImage.bottomAnchor),

			playerNameView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			playerNameView.leadingAnchor.constraint(equalTo: playerImage.trailingAnchor, constant: 7),
			playerNameView.widthAnchor.constraint(equalToConstant: 249),
			playerNameView.heightAnchor.constraint(equalToConstant: 46),

			playerNameLabel.centerYAnchor.constraint(equalTo: playerNameView.centerYAnchor),
			playerNameLabel.leadingAnchor.constraint(equalTo: playerNameView.leadingAnchor, constant: 16),
			playerNameLabel.trailingAnchor.constraint(equalTo: playerNameView.trailingAnchor, constant: -16),
			
			playerNameButton.topAnchor.constraint(equalTo: playerNameView.topAnchor),
			playerNameButton.leadingAnchor.constraint(equalTo: playerNameView.leadingAnchor),
			playerNameButton.trailingAnchor.constraint(equalTo: playerNameView.trailingAnchor),
			playerNameButton.bottomAnchor.constraint(equalTo: playerNameView.bottomAnchor),
		])
	}
}

// MARK: - Actions

private extension LeaderBoardView {

	@objc
	func playerImageTapped(_ sender: UIButton) {
		delegate?.chooseImage()
	}

	@objc
	func playerNameTapped(_ sender: UIButton) {
		delegate?.editName()
	}
}

// MARK: - Setting UI

private extension LeaderBoardView {

	func addSubviews() {
		addSubview(playerImage)
		addSubview(playerNameView)

		playerImage.addSubview(playerImageButton)

		playerNameView.addSubview(playerNameLabel)
		playerNameView.addSubview(playerNameButton)
	}

	func addAction() {
		playerImageButton.addTarget(self, action: #selector(playerImageTapped), for: .touchUpInside)
		playerNameButton.addTarget(self, action: #selector(playerNameTapped), for: .touchUpInside)
	}

	func setupPlayerImage() {
		playerImage.isUserInteractionEnabled = true
	}
}

#if DEBUG
struct LeaderBoardViewProvider: PreviewProvider {
	static var previews: some View {
		Group {
			UINavigationController(rootViewController: LeaderBoardViewController()).preview()
		}
	}
}
#endif
