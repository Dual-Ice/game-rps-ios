//
//  StartScreenViewController.swift
//  rps-game-ios
//
//  Created by Alexander Bokhulenkov on 10.06.2024.
//

import UIKit

final class StartScreenViewController: UIViewController {
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("START", for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik", size: 16)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(#colorLiteral(red: 0.7684260011, green: 0.5614033341, blue: 0.4590145946, alpha: 1), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.7647058824, blue: 0.6, alpha: 1)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let resultsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("RESULTS", for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik", size: 16)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(#colorLiteral(red: 0.7684260011, green: 0.5614033341, blue: 0.4590145946, alpha: 1), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.7647058824, blue: 0.6, alpha: 1)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
//    MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
        
    }
    
    //    MARK: - Selectors
    
    @objc func startGame() {
        print("Start Game")
    }
    
    @objc func resultsGame() {
        print("Results Game")
    }
    
    //    MARK: - Helpers
    
    private func createUI() {
        view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.968627451, blue: 0.9843137255, alpha: 1)
        
        view.addSubview(startButton)
        startButtonConstraints()
        startButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        
        view.addSubview(resultsButton)
        resultsButtonConstraints()
        resultsButton.addTarget(self, action: #selector(resultsGame), for: .touchUpInside)
        
    }
    
    func startButtonConstraints() {
        NSLayoutConstraint.activate([
            startButton.widthAnchor.constraint(equalToConstant: 196),
            startButton.heightAnchor.constraint(equalToConstant: 53),
            startButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 622),
            startButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 90.5)
        ])
    }
    
    func resultsButtonConstraints() {
        NSLayoutConstraint.activate([
            resultsButton.widthAnchor.constraint(equalToConstant: 196),
            resultsButton.heightAnchor.constraint(equalToConstant: 53),
            resultsButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 11),
            resultsButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 90.5)
        ])
    }

    
}
