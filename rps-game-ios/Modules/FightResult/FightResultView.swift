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

protocol IFightResultViewDelegate: AnyObject {
	func homeGame()
	func repeatGame()
}

final class FightResultView: UIView {

	// MARK: - Dependencies

	private weak var delegate: IFightResultViewDelegate?

	// MARK: - Private properties

	private lazy var backgroundImageView: UIImageView = makeImageView()
	private lazy var mainStack: UIStackView = makeStack()

	private lazy var circleView: UIView = makeView()
	private lazy var characterImage: UIImageView = makeImageView()

	private lazy var labelStack: UIStackView = makeStack()
	private lazy var resultLabel: UILabel = LabelFactory.makeSmallLabel(text: ResultGame.lose.text)
	private lazy var scoreLabel: UILabel = makeLabel()

	private lazy var buttonStack: UIStackView = makeStack()
	private lazy var homeButton: UIButton = ButtonFactory.make3DButtonWithIcon(imageName: "house-icon")
	private lazy var repeatButton: UIButton = ButtonFactory.make3DButtonWithIcon(imageName: "repeat-icon")
	
	// MARK: - Initialization

	init(delegate: IFightResultViewDelegate) {
		super.init(frame: .zero)
		self.delegate = delegate
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Public methods

	/// Заглушка для экрана
	func setStubState() {
		backgroundImageView.image = ResultGame.lose.backgroundImage
		characterImage.image = UIImage(systemName: "person.fill")
		resultLabel.textColor = .black
		scoreLabel.text = "1 - 3"
	}
}

// MARK: - Setup UI

extension FightResultView {
	
	/// Установка UI элементов
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

		element.backgroundColor = UIColor(red: 43 / 255.0, green: 40 / 255.0, blue: 112 / 255.0, alpha: 1)
		element.layer.cornerRadius = 88
		element.translatesAutoresizingMaskIntoConstraints = false

		return element
	}

	private func makeLabel() -> UILabel {
		let element = UILabel()

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

		static let blueBackground = UIImage(named: "blue-background")
		static let redBackground = UIImage(named: "red-background")

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
				ResultGame.blueBackground
			case .lose:
				ResultGame.redBackground
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
			FightResultViewController().previw()
		}
	}
}
#endif
