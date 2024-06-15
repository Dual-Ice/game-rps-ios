//
//  LeaderBoardViewController.swift
//  rps-game-ios
//
//  Created by Дмитрий Лубов on 14.06.2024.
//

import UIKit
#if DEBUG
import SwiftUI
#endif

final class LeaderBoardViewController: UIViewController {
    
    // MARK: - Outlets
    
    // MARK: - Public properties
    
    // MARK: - Dependencies
    
    // MARK: - Private properties
    
    private lazy var leaderBoardView = LeaderBoardView(delegate: self)
    private let gameService: GameService
    
    private var player: PlayerData?
    private var leaderList: [LeaderBoardPlayer]?
    private var nameModalView: NameModalView?
    private var avatarModalView: AvatarModalView?
    
    // MARK: - Initialization
    
    init(gameService: GameService) {
        self.gameService = gameService
        player = gameService.getBottomPlayer()
        leaderList = gameService.getLeaderList()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = leaderBoardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updatePlayerImage()
        updatePlayerName()
        leaderBoardView.fillLeaderList(leaderList ?? [])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        leaderBoardView.layout()
    }
    
    // MARK: - Public methods
    
    // MARK: - Private methods
    
    private func updatePlayerImage() {
        leaderBoardView.setPlayerImage(player?.image ?? UIImage.playerOne)
    }
    
    private func updatePlayerName() {
        leaderBoardView.setPlayerName(player?.name ?? "Player 1")
    }
    
    func extractNumber(from string: String) -> Int? {
        // Создаем регулярное выражение для поиска чисел
        let pattern = "character-(\\d+)"
        
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let nsString = string as NSString
            let results = regex.matches(in: string, range: NSRange(location: 0, length: nsString.length))
            
            if let match = results.first {
                // Извлекаем найденное число и преобразуем его в Int
                let numberRange = match.range(at: 1)
                let numberString = nsString.substring(with: numberRange)
                return Int(numberString)
            }
        } catch let error {
            print("Invalid regex: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    private func showEditNameModal() {
        nameModalView = NameModalView(frame: view.bounds)
        nameModalView?.delegate = self
        nameModalView?.setText(player?.name ?? "")
        
        view.addSubview(nameModalView!)
    }
    
    private func showEditAvatarModal() {
        avatarModalView = AvatarModalView(frame: view.bounds)
        avatarModalView?.delegate = self
        if let playerImageName = player?.imageName {
            let avatarIndex = extractNumber(from: playerImageName) ?? 1
            avatarModalView?.setSelectedAvatar(avatarIndex)
        } else {
            avatarModalView?.setSelectedAvatar(1)
        }
        
        view.addSubview(avatarModalView!)
    }
}

extension LeaderBoardViewController: NameModalViewDelegate {
    func submitName(_ name: String) {
        gameService.setBottomPlayerName(name)
        player?.name = name
        updatePlayerName()
    }
}
extension LeaderBoardViewController: AvatarModalViewDelegate {
    func submitAvatar(_ avatarIndex: Int) {
        let avatarName = "character-\(avatarIndex)"
        gameService.setBottomPlayerAvatar(avatarName)
        player?.imageName = avatarName
        player?.image = UIImage(named: avatarName)!
        updatePlayerImage()
    }
}

// MARK: - ILeaderBoardViewDelegate

extension LeaderBoardViewController: ILeaderBoardViewDelegate {
    
    /// Выбрать картинку игрока
    func chooseImage() {
        showEditAvatarModal()
    }
    
    /// Изменить имя игрока
    func editName() {
        showEditNameModal()
    }
    
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Setup UI

private extension LeaderBoardViewController {
    
    func setupUI() {
        title = "Leaderboard"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.titleTextAttributes = [.font: RubikFont.Regular.size(of: 25)]
        leaderBoardView.setupUI()
    }
}

#if DEBUG
struct LeaderBoardViewControllerProvider: PreviewProvider {
    static var previews: some View {
        Group {
            UINavigationController(rootViewController: LeaderBoardViewController(gameService: GameService())).preview()
        }
    }
}
#endif
