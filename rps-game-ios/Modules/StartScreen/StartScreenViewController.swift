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
    }
}
