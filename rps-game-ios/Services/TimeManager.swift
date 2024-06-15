//
//  TimeManager.swift
//  rps-game-ios
//
//  Created by  Maksim Stogniy on 15.06.2024.
//
import Foundation

protocol TimeManagerProtocol: AnyObject {
    var delegate: TimeManagerDelegate? { get set }
    
    func start()
    func stop()
    func isRun() -> Bool
}

protocol TimeManagerDelegate: AnyObject {
    func timerTick()
}

final class TimeManager: TimeManagerProtocol {
    static let shared = TimeManager(interval: 1.0)
    
    private var timer: Timer?
    private let timeInterval: TimeInterval
    private var isRunning = false
    
    weak var delegate: TimeManagerDelegate?
    
    private init(interval: TimeInterval) {
        self.timeInterval = interval
    }
    
    func start() {
        guard !isRunning else { return }
        timer = Timer.scheduledTimer(
            timeInterval: self.timeInterval,
            target: self,
            selector: #selector(timerTick),
            userInfo: nil,
            repeats: true
        )
        isRunning = true
    }
    
    func stop() {
        timer?.invalidate()
        isRunning = false
    }
    
    func isRun() -> Bool {
        return isRunning
    }
    
    @objc private func timerTick() {
        delegate?.timerTick()
    }
    
    deinit {
        stop()
    }
}
