//
//  SoundExtension.swift
//  rps-game-ios
//
//  Created by Alexander on 11.06.24.
//

import AVFoundation

extension AVAudioPlayer {
    static func playBackgroundMusic() -> AVAudioPlayer? {
        guard let url = Bundle.main.url(forResource: "backgroundMusic", withExtension: "mp3") else { return nil }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.numberOfLoops = -1
            player.prepareToPlay()
            player.play()
            return player
        } catch {
            print("Error loading audio file.")
            return nil
        }
    }
    
    static func playButtonPressingSound() -> AVAudioPlayer? {
        guard let url = Bundle.main.url(forResource: "buttonPressingSound", withExtension: "mp3") else { return nil }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
            return player
        } catch {
            print("Error loading audio file.")
            return nil
        }
    }
}
