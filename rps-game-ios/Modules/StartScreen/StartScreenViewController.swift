//
//  StartScreenViewController.swift
//  rps-game-ios
//
//  Created by Alexander Bokhulenkov on 10.06.2024.
//

import UIKit

final class StartScreenViewController: UIViewController {
    
    private let startScreenView = StartScreenView()
    
    override func loadView() {
         view = startScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startScreenView.delegate = self
        
        // Установка пустого текста для кнопки "Назад"
            let backButton = UIBarButtonItem()
            backButton.title = ""
            navigationItem.backBarButtonItem = backButton
    }
    
    func didTapRulesButton() {
        let secondVC = RulesViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
}

extension StartScreenViewController: StartScreenViewDelegate {
    func didTapStartButton() {
        print("start")
    }
    
    func didTapResultButton() {
        print("result")
    }
    
    func didTapSettingsButton() {
        print("settings")
    }
}
