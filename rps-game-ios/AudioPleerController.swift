//
//  gameMusic.swift
//  rps-game-ios
//
//  Created by Ольга Чушева on 14.06.2024.
//

import Foundation
import AVFoundation

struct GameMusic {
    
    
    var player: AVAudioPlayer!
    
    var musicClick = AVAudioPlayer.SoundFiles.self
    
    
    mutating func  playMusicClick() {
        player = try! AVAudioPlayer(contentsOf: musicClick.buttonClick!)
        player.play()
    }
    
  
    mutating func playSound() {
        player = try! AVAudioPlayer(contentsOf: musicClick.backgroundMusic!)
        player.play()
      //  player.currentTime
    }
    
    mutating func stopSound() {
        player = try! AVAudioPlayer(contentsOf: musicClick.backgroundMusic!)
        player.stop()
    }
    
}


