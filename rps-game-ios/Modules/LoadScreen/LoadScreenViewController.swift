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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
