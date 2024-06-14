//
//  LoadScreenViewController.swift
//  rps-game-ios
//
//  Created by Alexander on 11.06.24.
//

import UIKit

class LoadScreenViewController: UIViewController {
    
    private let loadScreenView = LoadScreenView()
    
    override func loadView() {
        super.loadView()
        view = loadScreenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
