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
        guard let currentTrack = currentTrack else {
            return false
        }
        
        return currentTrack.isPlaying
    }
    
    init(tracks: [Track] = [], currentTrack: Track, repeateState: RepeatState = .off) {
        self.tracks = tracks
        self.currentTrack = currentTrack
        self.repeateState = repeateState
    }
    
    init(tracks: [Track] = []) {
        self.tracks = tracks
    }
    
    func isCurrentTrackLast() -> Bool {
        guard let currentTrack = currentTrack else {
            return true
        }
        
        return currentTrack.isEqual(tracks.last)
        
    }
    
    func isCurrentTrackFirst() -> Bool {
        guard let currentTrack = currentTrack else {
            return true
        }
        
        return currentTrack.isEqual(tracks.first)
    }
    
    private func changeTrack(index: Int)  {
        currentTrack?.stop()
        currentTrack = tracks[index]
        currentTrack?.play()
    }
    
    func changeTrack(track: Track)  {
        currentTrack?.stop()
        currentTrack = track
        currentTrack?.play()
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
        
        guard let currentTrack = currentTrack else {
            return nil
        }
        
        guard let currentIndex = tracks.firstIndex(of: currentTrack) else {
            return nil
        }
        
        switch repeateState {
        case .off:
            if isCurrentTrackLast() {
                return nil
            }
            changeTrack(index: currentIndex + 1)
            
        case .loop:
            if isCurrentTrackLast() {
                changeTrack(index: tracks.startIndex)
                return self.currentTrack
            }
            
            changeTrack(index: currentIndex + 1)
            
        case .repeatOne:
            changeTrack(index: currentIndex)
        }
        return self.currentTrack
    }
    
    func back() -> Track? {
        guard let currentTrack = currentTrack else {
            return nil
        }
        
        guard let currentIndex = tracks.firstIndex(of: currentTrack) else {
            return nil
        }
        
        switch repeateState {
        case .off:
            if isCurrentTrackFirst() {
                return nil
            }
            changeTrack(index: currentIndex - 1)
            
        case .loop:
            if isCurrentTrackFirst() {
                changeTrack(index: tracks.endIndex - 1)
                return self.currentTrack
            }
            changeTrack(index: currentIndex - 1)
        
        case .repeatOne:
            changeTrack(index: currentIndex)
        }
        
        return self.currentTrack
    }
        
    func play() {
        if isPlaying {
            currentTrack?.pause()
            return
        }
        currentTrack?.play()
    }
    
    func rewindTo(newTime: TimeInterval)  {
        currentTrack?.rewindTo(newTime: newTime)
    }
    
    
    

    
}
