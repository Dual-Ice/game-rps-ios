//
//  SoundExtension.swift
//  rps-game-ios
//
//  Created by Alexander on 11.06.24.
//

import AVFoundation

extension AVAudioPlayer {
    struct SoundFiles {
        static let buttonClick = Bundle.main.url(forResource: "buttonClick", withExtension: "mp3")
        static let backgroundMusic = Bundle.main.url(forResource: "backgroundMusic", withExtension: "mp3")
        static let backgroundMusic2 = Bundle.main.url(forResource: "music2", withExtension: "mp3")
    }
}
