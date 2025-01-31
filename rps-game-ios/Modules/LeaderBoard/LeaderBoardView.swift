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
    
    func didTapBackButton()
}

final class LeaderBoardView: UIView {
	
	// MARK: - Outlets
	
	// MARK: - Public properties
	
	// MARK: - Dependencies

	private weak var delegate: ILeaderBoardViewDelegate?

	// MARK: - Private properties
	private var leaderList: [LeaderBoardPlayer]?
    
    private let title = LabelFactory.makeScreenLabel(text: "Leaderboard")
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.CustomImage.arrowLeft, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
    
        return button
    }()

	private lazy var backgroundLayer: CAGradientLayer = makeGradientLayer()

    private lazy var topTenImage: UIImageView = {
        let element = UIImageView()
        element.image = UIImage.init(named: "top10")
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false

        return element
    }()
	private lazy var playerImage: UIImageView = makeImageView()
	private lazy var playerImageButton: UIButton = makeButton()

	private lazy var playerNameView: UIView = makeView()
	private lazy var playerNameLabel: UILabel = makeLabel()
	private lazy var playerNameButton: UIButton = makeButton()
    
    private let tablePlayerLabel: UILabel = {
        let element = UILabel()
        element.text = "Player"
        element.font = RubikFont.Bold.size(of: 13)
        element.textColor = UIColor.CustomColors.grayLeaderText
        element.translatesAutoresizingMaskIntoConstraints = false

        return element
    }()
    private let tableScoreLabel: UILabel = {
        let element = UILabel()
        element.text = "Score"
        element.font = RubikFont.Bold.size(of: 13)
        element.textColor = UIColor.CustomColors.grayLeaderText
        element.translatesAutoresizingMaskIntoConstraints = false

        return element
    }()
    private let tableRateLabel: UILabel = {
        let element = UILabel()
        element.text = "Rate"
        element.font = RubikFont.Bold.size(of: 13)
        element.textColor = UIColor.CustomColors.grayLeaderText
        element.translatesAutoresizingMaskIntoConstraints = false

        return element
    }()

	private lazy var leaderListView = makeView()
	private lazy var leaderListStack = makeStackView()
	private lazy var leaderTableView = makeTableView()

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

	func fillLeaderList(_ leaderList: [LeaderBoardPlayer]) {
		self.leaderList = leaderList
		setupLeaderListStak()
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
		setupPlayerNameView()
		setupLeaderListView()
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

		element.contentMode = .scaleAspectFit
		element.translatesAutoresizingMaskIntoConstraints = false

		return element
	}

	private func makeView() -> UIView {
		let element = UIView()

		element.backgroundColor = .white
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

	private func makeStackView() -> UIStackView {
		let element = UIStackView()

		element.axis = .vertical
		element.spacing = 10
		element.distribution = .fill
		element.translatesAutoresizingMaskIntoConstraints = false
		return element
	}

	private func makeTableView() -> UITableView {
		let element = UITableView()

		element.dataSource = self
		element.delegate = self
		element.register(LeaderViewCell.self, forCellReuseIdentifier: LeaderViewCell.Identifier)
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
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            
            backButton.topAnchor.constraint(equalTo: title.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23),
            backButton.heightAnchor.constraint(equalTo: title.heightAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 11),
            
			playerImage.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 15),
			playerImage.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
			playerImage.widthAnchor.constraint(equalToConstant: 46),
			playerImage.heightAnchor.constraint(equalToConstant: 46),

			playerImageButton.topAnchor.constraint(equalTo: playerImage.topAnchor),
			playerImageButton.leadingAnchor.constraint(equalTo: playerImage.leadingAnchor),
			playerImageButton.trailingAnchor.constraint(equalTo: playerImage.trailingAnchor),
			playerImageButton.bottomAnchor.constraint(equalTo: playerImage.bottomAnchor),

			playerNameView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 15),
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
            
            
            topTenImage.centerXAnchor.constraint(equalTo: leaderListView.centerXAnchor),
            topTenImage.topAnchor.constraint(equalTo: leaderListView.topAnchor, constant: -25),
            topTenImage.widthAnchor.constraint(equalToConstant: 164),
            topTenImage.heightAnchor.constraint(equalToConstant: 95),
            
			leaderListView.topAnchor.constraint(equalTo: playerImage.bottomAnchor, constant: 45),
			leaderListView.leadingAnchor.constraint(equalTo: leadingAnchor),
			leaderListView.trailingAnchor.constraint(equalTo: trailingAnchor),
			leaderListView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            tablePlayerLabel.topAnchor.constraint(equalTo: leaderListStack.topAnchor, constant: -25),
            tablePlayerLabel.leftAnchor.constraint(equalTo: leaderListView.leftAnchor, constant: 50),
            
            tableScoreLabel.topAnchor.constraint(equalTo: leaderListStack.topAnchor, constant: -25),
            tableScoreLabel.rightAnchor.constraint(equalTo: tableRateLabel.leftAnchor, constant: -40),
            
            tableRateLabel.topAnchor.constraint(equalTo: leaderListStack.topAnchor, constant: -25),
            tableRateLabel.rightAnchor.constraint(equalTo: leaderListView.rightAnchor, constant: -60),
            
			leaderListStack.topAnchor.constraint(equalTo: leaderListView.topAnchor, constant: 100),
			leaderListStack.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
			leaderListStack.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),

			leaderTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
		])
	}
}

// MARK: - TableViewDataSource

extension LeaderBoardView: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let numberOfRows = leaderList?.count, numberOfRows > 3 else { return 0 }
		return numberOfRows - 3
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: LeaderViewCell.Identifier, for: indexPath)
		guard let cell = cell as? LeaderViewCell else { return UITableViewCell() }

		let player = leaderList![indexPath.row + 3]
		cell.configure(by: indexPath, with: player)
		
		return cell
	}
}

// MARK: - TableViewDelegate

extension LeaderBoardView: UITableViewDelegate {

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		65
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
    
    @objc func backButtonTapped() {
        delegate?.didTapBackButton()
    }
}

// MARK: - Setting UI

private extension LeaderBoardView {

	func addSubviews() {
        addSubview(title)
        addSubview(backButton)
        addSubview(topTenImage)
		addSubview(playerImage)
		addSubview(playerNameView)
		addSubview(leaderListView)

		playerImage.addSubview(playerImageButton)

		playerNameView.addSubview(playerNameLabel)
		playerNameView.addSubview(playerNameButton)

        leaderListView.addSubview(tablePlayerLabel)
        leaderListView.addSubview(tableScoreLabel)
        leaderListView.addSubview(tableRateLabel)
        leaderListView.addSubview(topTenImage)
		leaderListView.addSubview(leaderListStack)
	}

	func addAction() {
		playerImageButton.addTarget(self, action: #selector(playerImageTapped), for: .touchUpInside)
		playerNameButton.addTarget(self, action: #selector(playerNameTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
	}

	func setupPlayerImage() {
		playerImage.isUserInteractionEnabled = true
	}

	func setupPlayerNameView() {
		playerNameView.layer.borderWidth = 1
		playerNameView.layer.borderColor = UIColor.CustomColors.grayBorder.cgColor
		playerNameView.layer.cornerRadius = 23
	}

	func setupLeaderListView() {
		leaderListView.layer.cornerRadius = 40
	}

	func setupLeaderListStak() {
		guard let leaderList else { return }

		let topThere = leaderList.prefix(3)
		
		for (index, player) in topThere.enumerated() {
			let view = LeaderViewFactory.makeLeaderView(number: index, player: player)
			leaderListStack.addArrangedSubview(view)
			view.heightAnchor.constraint(equalToConstant: 65).isActive = true
		}
		
		leaderListStack.addArrangedSubview(leaderTableView)
	}
}

#if DEBUG
struct LeaderBoardViewProvider: PreviewProvider {
	static var previews: some View {
		Group {
			UINavigationController(rootViewController: LeaderBoardViewController(gameService: GameService())).preview()
		}
	}
}
#endif
