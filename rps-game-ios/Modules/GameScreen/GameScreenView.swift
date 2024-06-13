//
//  GameScreenView.swift
//  rps-game-ios
//
//  Created by nikita on 12.06.24.
//

import UIKit

protocol GameScreenViewDelegate: AnyObject {
    //Назад
    
    //Пауза
    //Камень
    //Ножницы
    //Бумага
}

final class GameScreenView: UIView {
    
    // MARK: - Dependencies
    weak var delegate: GameScreenViewDelegate?
    
    // MARK: - Private properties
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.CustomImage.backgroundImage
        return imageView
    }()
    
    private let topHandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "femaleHand")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let timerView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progress = 0.7
        progressView.progressTintColor = UIColor.CustomColors.darkGreenTimeline
        progressView.trackTintColor = UIColor.CustomColors.darkBlueCircle
        progressView.layer.cornerRadius = 5
        progressView.clipsToBounds = true
        progressView.transform = CGAffineTransform(rotationAngle: .pi / -2)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "0:20"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let centralLabel: UILabel = LabelFactory.makeLargeLabel(text: "FIGHT")
    
    private let scoreView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progress = 0.2
        progressView.progressTintColor = UIColor.CustomColors.pastelYellowText
        progressView.trackTintColor = UIColor.CustomColors.darkBlueCircle
        progressView.layer.cornerRadius = 5
        progressView.clipsToBounds = true
        progressView.transform = CGAffineTransform(rotationAngle: .pi / -2)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private let bottomHandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "maleHand")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let rockButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "rockIcon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let paperButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "paperIcon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let scissorsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "scissorsIcon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
        setupConstrains()
    }
    
}

// MARK: - Setup UI
private extension GameScreenView {
    func setViews() {
        [
            backgroundImageView,
            topHandImageView,
            timerView,
            timerLabel,
            centralLabel,
            scoreView,
            bottomHandImageView,
            rockButton,
            paperButton,
            scissorsButton
            
        ].forEach{ addSubview($0) }
    }
    
    func setupConstrains() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            topHandImageView.topAnchor.constraint(equalTo: topAnchor, constant: -80),
            topHandImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -40),
            
            timerView.widthAnchor.constraint(equalToConstant: 200),
            timerView.heightAnchor.constraint(equalToConstant: 10),
            timerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            timerView.centerXAnchor.constraint(equalTo: leadingAnchor, constant: 26),
            
            timerLabel.centerXAnchor.constraint(equalTo: timerView.centerXAnchor),
            timerLabel.topAnchor.constraint(equalTo: timerView.bottomAnchor, constant: 100),
            
            centralLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            centralLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            scoreView.widthAnchor.constraint(equalToConstant: 300),
            scoreView.heightAnchor.constraint(equalToConstant: 10),
            scoreView.centerYAnchor.constraint(equalTo: centerYAnchor),
            scoreView.centerXAnchor.constraint(equalTo: trailingAnchor, constant: -26),
            
            bottomHandImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 80),
            bottomHandImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 40),
            
            rockButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -80),
            rockButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            
            paperButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            paperButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80),
            
            scissorsButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 80),
            scissorsButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40)
        ])
    }
}


#if DEBUG
import SwiftUI

struct GameScreenViewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            UINavigationController(rootViewController: GameScreenViewController()).previw()
        }
    }
}
#endif
 
