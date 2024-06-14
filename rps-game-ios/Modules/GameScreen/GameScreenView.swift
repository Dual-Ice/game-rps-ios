//
//  GameScreenView.swift
//  rps-game-ios
//
//  Created by nikita on 12.06.24.
//

import UIKit

protocol GameScreenViewDelegate: AnyObject {
    func didTapRockButton()
    func didTapPaperButton()
    func didTapScissorsButton()
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
            
    private let topCharacterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "playerOne")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let topScoreView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bottomScoreView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bottomCharacterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "playerTwo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let centralLabel: UILabel = LabelFactory.makeLargeLabel(text: "FIGHT")
    
    let topHandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "femaleHand")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let bottomHandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "maleHand")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let timerProgressView: UIProgressView = {
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
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "0:20"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let topScoreProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progress = 0.3
        progressView.progressTintColor = UIColor.CustomColors.pastelYellowText
        progressView.trackTintColor = UIColor.CustomColors.darkBlueCircle
        progressView.clipsToBounds = true
        progressView.transform = CGAffineTransform(rotationAngle: .pi / 2)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    let bottomScoreProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progress = 0.3
        progressView.progressTintColor = UIColor.CustomColors.pastelYellowText
        progressView.trackTintColor = UIColor.CustomColors.darkBlueCircle
        progressView.clipsToBounds = true
        progressView.transform = CGAffineTransform(rotationAngle: .pi / -2)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    let rockButton = ButtonFactory.makeActionButton(icon: "rockIcon")
    let paperButton = ButtonFactory.makeActionButton(icon: "paperIcon")
    let scissorsButton = ButtonFactory.makeActionButton(icon: "scissorsIcon")
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setupConstrains()
        setupTargetAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
        setupConstrains()
        setupTargetAction()
    }
}

// MARK: - Selevtors
private extension GameScreenView {
    @objc func rockButtonAction() {
        delegate?.didTapRockButton()
    }
    @objc func paperButtonAction() {
        delegate?.didTapPaperButton()
    }
    @objc func scissorsButtonAction() {
        delegate?.didTapScissorsButton()
    }
}

// MARK: - Setup UI
private extension GameScreenView {
    func setViews() {
        topScoreView.addSubview(topScoreProgressView)
        bottomScoreView.addSubview(bottomScoreProgressView)
        [
            backgroundImageView,
            topHandImageView,
            timerProgressView,
            timerLabel,
            centralLabel,
            topScoreView,
            topCharacterImage,
            bottomScoreView,
            bottomCharacterImage,
            bottomHandImageView,
            rockButton,
            paperButton,
            scissorsButton
            
        ].forEach{ addSubview($0) }
    }
    
    func setupTargetAction() {
        rockButton.addTarget(self, action: #selector(rockButtonAction), for: .touchUpInside)
        paperButton.addTarget(self, action: #selector(paperButtonAction), for: .touchUpInside)
        scissorsButton.addTarget(self, action: #selector(scissorsButtonAction), for: .touchUpInside)
    }
    
    func setupConstrains() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            topHandImageView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -120),
            topHandImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -40),
            
            timerProgressView.widthAnchor.constraint(equalToConstant: 200),
            timerProgressView.heightAnchor.constraint(equalToConstant: 10),
            timerProgressView.centerYAnchor.constraint(equalTo: centerYAnchor),
            timerProgressView.centerXAnchor.constraint(equalTo: leadingAnchor, constant: 26),
            
            timerLabel.centerXAnchor.constraint(equalTo: timerProgressView.centerXAnchor),
            timerLabel.topAnchor.constraint(equalTo: timerProgressView.bottomAnchor, constant: 100),
            
            centralLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            centralLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            topCharacterImage.widthAnchor.constraint(equalToConstant: 35),
            topCharacterImage.centerYAnchor.constraint(equalTo: topScoreView.topAnchor),
            topCharacterImage.centerXAnchor.constraint(equalTo: topScoreView.centerXAnchor),
              
            topScoreView.widthAnchor.constraint(equalToConstant: 10),
            topScoreView.heightAnchor.constraint(equalToConstant: 150),
            topScoreView.bottomAnchor.constraint(equalTo: centerYAnchor),
            topScoreView.centerXAnchor.constraint(equalTo: trailingAnchor, constant: -26),
            
            topScoreProgressView.widthAnchor.constraint(equalToConstant: 150),
            topScoreProgressView.heightAnchor.constraint(equalToConstant: 10),
            topScoreProgressView.centerYAnchor.constraint(equalTo: topScoreView.centerYAnchor),
            topScoreProgressView.centerXAnchor.constraint(equalTo: topScoreView.centerXAnchor),
            
            bottomScoreView.widthAnchor.constraint(equalToConstant: 10),
            bottomScoreView.heightAnchor.constraint(equalToConstant: 150),
            bottomScoreView.topAnchor.constraint(equalTo: centerYAnchor, constant: 1),
            bottomScoreView.centerXAnchor.constraint(equalTo: trailingAnchor, constant: -26),
            
            bottomScoreProgressView.widthAnchor.constraint(equalToConstant: 150),
            bottomScoreProgressView.heightAnchor.constraint(equalToConstant: 10),
            bottomScoreProgressView.centerYAnchor.constraint(equalTo: bottomScoreView.centerYAnchor),
            bottomScoreProgressView.centerXAnchor.constraint(equalTo: bottomScoreView.centerXAnchor),
            
            bottomCharacterImage.widthAnchor.constraint(equalToConstant: 35),
            bottomCharacterImage.centerYAnchor.constraint(equalTo: bottomScoreView.bottomAnchor),
            bottomCharacterImage.centerXAnchor.constraint(equalTo: bottomScoreView.centerXAnchor),
            
            bottomHandImageView.topAnchor.constraint(equalTo: centerYAnchor, constant: 120),
            bottomHandImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 40),
            
            rockButton.widthAnchor.constraint(equalToConstant: 80),
            rockButton.heightAnchor.constraint(equalToConstant: 80),
            rockButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -100),
            rockButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            
            paperButton.widthAnchor.constraint(equalToConstant: 80),
            paperButton.heightAnchor.constraint(equalToConstant: 80),
            paperButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            paperButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80),
            
            scissorsButton.widthAnchor.constraint(equalToConstant: 80),
            scissorsButton.heightAnchor.constraint(equalToConstant: 80),
            scissorsButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 100),
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
 
