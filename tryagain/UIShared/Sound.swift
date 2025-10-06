//
//  Sound.swift
//  tryagain
//
//  Created by Aasiya Memon on 5/21/23.
//


import AVFoundation

final class Sound {
    static let shared = Sound()
    private init() { configureSession() }

    private var sfxPools: [String: [AVAudioPlayer]] = [:]
    private var musicPlayer: AVAudioPlayer?

    var sfxEnabled = true
    var musicEnabled = true {
        didSet {
            if musicEnabled {
                musicPlayer?.play()
            } else {
                musicPlayer?.pause()
            }
        }
    }

    private func configureSession() {
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(.ambient, mode: .default, options: [.mixWithOthers])
        try? session.setActive(true)
        NotificationCenter.default.addObserver(self,
            selector: #selector(handleInterruption(_:)),
            name: AVAudioSession.interruptionNotification, object: nil)
    }

    // preload so effects can overlap!!!
    func preloadSFX(named filename: String, copies: Int = 2) {
        guard sfxPools[filename] == nil else { return }
        var pool: [AVAudioPlayer] = []
        for _ in 0..<copies {
            if let url = Bundle.main.url(forResource: filename, withExtension: nil),
               let p = try? AVAudioPlayer(contentsOf: url) {
                p.prepareToPlay() // reduces first-play latency
                pool.append(p)
            }
        }
        sfxPools[filename] = pool
    }

    func playSFX(_ filename: String, volume: Float = 1.0) {
        guard sfxEnabled, let pool = sfxPools[filename] else { return }
        let player = pool.first(where: { !$0.isPlaying }) ?? pool.first
        player?.currentTime = 0
        player?.volume = volume
        player?.play()
    }

    func startMusic(_ filename: String, volume: Float = 0.7) {
            guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else {
                return
            }
            do {
                musicPlayer = try AVAudioPlayer(contentsOf: url)
                musicPlayer?.numberOfLoops = -1
                musicPlayer?.volume = volume
                musicPlayer?.prepareToPlay()
                if musicEnabled { musicPlayer?.play() }   // actually play
            } catch {
                print("music player FAILED: ", error)
            }
        }

    func stopMusic() { musicPlayer?.stop(); musicPlayer = nil }

    @objc private func handleInterruption(_ note: Notification) {
        guard let info = note.userInfo,
              let typeVal = info[AVAudioSessionInterruptionTypeKey] as? UInt,
              let type = AVAudioSession.InterruptionType(rawValue: typeVal) else { return }
        if type == .ended, musicEnabled { musicPlayer?.play() }
    }
}
