//
//  Playlist.swift
//  MySpotify
//
//  Created by Sabina Grinenko on 29.08.2023.
//

import UIKit

enum RepeatState {
    case off
    case loop
    case repeatOne
}

class Playlist: NSObject {
    var tracks: [Track]
    var currentTrack: Track?
    var repeateState =  RepeatState.off
    
    
    var isPlaying: Bool {
        if let currentTrack =  currentTrack {
            return currentTrack.player.isPlaying
        }
        return false
    }
    
    init(tracks: [Track] = [], currentTrack: Track, repeateState: RepeatState = .off) {
        self.tracks = tracks
        self.currentTrack = currentTrack
        self.repeateState = repeateState
    }
    
    init(tracks: [Track] = []) {
        self.tracks = tracks
        self.currentTrack = tracks.first
    }
    
    func isCurrentTrackLast() -> Bool {
        if let currentTrack = currentTrack {
            return currentTrack.isEqual(tracks.last)
        }
        return true
    }
    
    func isCurrentTrackFirst() -> Bool {
        if let currentTrack = currentTrack {
            return currentTrack.isEqual(tracks.first)
        }
        return true
    }
    
    private func changeTrack(index: Int)  {
        currentTrack?.player.stop()
        currentTrack?.player.currentTime = 0
        currentTrack = tracks[index]
        currentTrack?.player.play()
    }
    
    func changeTrack(track: Track)  {
        currentTrack?.player.stop()
        currentTrack?.player.currentTime = 0
        currentTrack = track
        currentTrack?.player.play()
    }
    
    func changeRepeateState()  {
        switch repeateState {
        case .off:
            repeateState = .loop
        case .loop:
            repeateState = .repeatOne
        case .repeatOne:
            repeateState = .off
        }
    }
    

    func next() -> Track? {
        switch repeateState {
        case .off:
            if isCurrentTrackLast() {
                return nil
            }
            
            if let currentTrack = currentTrack {
                if let currentIndex = tracks.firstIndex(of: currentTrack) {
                    changeTrack(index: currentIndex + 1)
                }
            }
            
        case .loop:
            if isCurrentTrackLast() {
                changeTrack(index: tracks.startIndex)
                return currentTrack
            }
            
            if let currentTrack = currentTrack {
                if let currentIndex = tracks.firstIndex(of: currentTrack) {
                    changeTrack(index: currentIndex + 1)
                }
            }
            
        case .repeatOne:
            if let currentTrack = currentTrack {
                if let currentIndex = tracks.firstIndex(of: currentTrack) {
                    changeTrack(index: currentIndex)
                }
            }
        }
        
        return currentTrack
    }
    
    func back() -> Track? {
        switch repeateState {
        case .off:
            if isCurrentTrackFirst() {
                return nil
            }
            
            if let currentTrack = currentTrack {
                if let currentIndex = tracks.firstIndex(of: currentTrack) {
                    changeTrack(index: currentIndex - 1)
                }
            }
            
        case .loop:
            if isCurrentTrackFirst() {
                changeTrack(index: tracks.endIndex - 1)
                return currentTrack
            }
            
            if let currentTrack = currentTrack {
                if let currentIndex = tracks.firstIndex(of: currentTrack) {
                    changeTrack(index: currentIndex - 1)
                }
            }
            
        case .repeatOne:
            if let currentTrack = currentTrack {
                if let currentIndex = tracks.firstIndex(of: currentTrack) {
                    changeTrack(index: currentIndex)
                }
            }
        }
        
        return currentTrack
    }
        
    func play() {
        if isPlaying {
            currentTrack?.player.pause()
            return
        }
        currentTrack?.player.play()
    }
    
    func rewindTo(newTime: TimeInterval)  {
        currentTrack?.player.currentTime = newTime
    }
    
    
    

    
}
