//
//  gameMusic.swift
//  rps-game-ios
//
//  Created by Ольга Чушева on 14.06.2024.
//

import Foundation
import AVFoundation

final class AudioPleerController {
    
    private var buttonClickPlayer: AVAudioPlayer?
    private var backgroundMusicPlayer: AVAudioPlayer?
    private var punchMusicPlayer: AVAudioPlayer?
    
    init(backgroundMusicFileName: String) {
        if let buttonClickURL = Bundle.main.url(forResource: SoundFiles.buttonClick, withExtension: "mp3") {
            do {
                buttonClickPlayer = try AVAudioPlayer(contentsOf: buttonClickURL)
            } catch {
                print("Ошибка инициализации AVAudioPlayer для звука кнопки: \(error)")
            }
        }
        
        if let punchSoundURL = Bundle.main.url(forResource: SoundFiles.punch, withExtension: "mp3") {
            do {
                punchMusicPlayer = try AVAudioPlayer(contentsOf: punchSoundURL)
            } catch {
                print("Ошибка инициализации AVAudioPlayer для звука удара: \(error)")
            }
        }
        
        if let backgroundMusicURL = Bundle.main.url(forResource: backgroundMusicFileName, withExtension: "mp3") {
            do {
                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: backgroundMusicURL)
                backgroundMusicPlayer?.numberOfLoops = -1
            } catch {
                print("Ошибка инициализации AVAudioPlayer для фоновой музыки: \(error)")
            }
        }
    }
    
    func playMusicClick() {
        buttonClickPlayer?.play()
    }
    
    func playBackgroundMusic() {
        backgroundMusicPlayer?.play()
    }
    
    func playPunchSound() {
        punchMusicPlayer?.play()
    }
    
    func stopBackgroundMusic() {
        backgroundMusicPlayer?.stop()
        backgroundMusicPlayer?.currentTime = 0
    }
}


