//
//  StartScreenViewController.swift
//  rps-game-ios
//
//  Created by Alexander Bokhulenkov on 10.06.2024.
//

import UIKit

final class StartScreenViewController: UIViewController, StartScreenViewDelegate {
    
    private let startScreenView = StartScreenView()
    
    override func loadView() {
         view = startScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startScreenView.delegate = self
    }
    
    func didTapRulesButton() {
        let secondVC = RulesViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    func didTapStartButton() {
        print("start")
    }
    
    func didTapResultButton() {
        print("result")
    }
}
