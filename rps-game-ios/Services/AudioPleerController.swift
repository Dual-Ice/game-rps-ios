//
//  gameMusic.swift
//  rps-game-ios
//
//  Created by Ольга Чушева on 14.06.2024.
//

import Foundation
import AVFoundation

final class AudioPleerController {
    
    
    var player: AVAudioPlayer!
    
    var musicClick = AVAudioPlayer.SoundFiles.self
    
    
    func playMusicClick() {
        player = try! AVAudioPlayer(contentsOf: musicClick.buttonClick!)
        player.play()
    }
    
  
    func playSound() {
        player = try! AVAudioPlayer(contentsOf: musicClick.backgroundMusic!)
        player.numberOfLoops = -1
        player.play()
    }
    
    func stopSound() {
        player = try! AVAudioPlayer(contentsOf: musicClick.backgroundMusic!)
        player.stop()
    }
    
}


