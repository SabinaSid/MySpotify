//
//  Track.swift
//  MySpotify
//
//  Created by Sabina Grinenko on 26.07.2023.
//

import UIKit
import AVFoundation

protocol TrackDelegete {
    func didFinishPlaying()
    func didChangeState(newState: TrackState, track: Track)
}

enum TrackState {
    case playing
    case paused
    case stopped
}

class Track: NSObject {
    
    private var player = AVAudioPlayer()
    var name: String = "City"
    var artist: String = "oxxxymiron"
    var coverImage: UIImage?
    var delegates: [TrackDelegete] = []
    private var state: TrackState = .stopped {
        didSet {
            print("didSet: \(state)")
            
            for item in delegates
            {
                item.didChangeState(newState: state, track: self)
            }
            
            print("didSet: log")
        }
    }
    
    var trackState: TrackState {
        get { return state }
    }
    
    var currentTime: TimeInterval {
        return player.currentTime
    }
    
    var duration: TimeInterval {
        return player.duration
    }
    
    init(name: String, artist: String, audioResource: String, audioType: String = "mp3", coverImage: UIImage? = nil) {
        super.init()
        self.name = name
        self.artist = artist
        self.coverImage = coverImage
        
        do {
            if let audioPath = Bundle.main.path(forResource: audioResource, ofType: audioType){
                try player = AVAudioPlayer(contentsOf: URL(filePath: audioPath))
                player.delegate = self
            }
            
        } catch {
            print("ERROR")
        }
    }
    
    func pause() {
        player.pause()
        state = .paused
    }
    
    func play() {
        player.play()
        state = .playing
    }
    
    func reset() {
        player.stop()
        player.currentTime = 0
        state = .stopped
    }
    
    func rewindTo(newTime: TimeInterval)  {
        player.currentTime = newTime
    }

}

extension Track: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        for item in delegates
        {
            item.didFinishPlaying()
        }
    }
    
}
