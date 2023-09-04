//
//  Playlist.swift
//  MySpotify
//
//  Created by Sabina Grinenko on 29.08.2023.
//

import UIKit

enum RepeateState {
    case off
    case loop
    case repeateOne
}

class Playlist: NSObject {
    var tracks: [Track]
    var currentTrack: Track?
    var repeateState =  RepeateState.off
    
    init(tracks: [Track] = [], currentTrack: Track, repeateState: RepeateState = .off) {
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
    

    func next() -> Track? {
        switch repeateState {
        case .off:
            if !isCurrentTrackLast(){
                currentTrack?.player.stop()
                currentTrack?.player.currentTime = 0
                if let currentTrack = currentTrack {
                    if let currentIndex = tracks.firstIndex(of: currentTrack) {
                        self.currentTrack = tracks[currentIndex + 1]
                    }
                }
            }
            
        case .loop:
            if !isCurrentTrackLast(){
                currentTrack?.player.stop()
                currentTrack?.player.currentTime = 0
                if let currentTrack = currentTrack {
                    if let currentIndex = tracks.firstIndex(of: currentTrack) {
                        self.currentTrack = tracks[currentIndex + 1]
                        return currentTrack
                    }
                }
            }
            if let first = tracks.first {
                currentTrack?.player.stop()
                currentTrack?.player.currentTime = 0
                currentTrack = first
            }
        case .repeateOne:
            currentTrack?.player.stop()
            currentTrack?.player.currentTime = 0
        }
        return currentTrack
    }
    
    func back() -> Track? {
        switch repeateState {
        case .off:
            if !isCurrentTrackFirst(){
                currentTrack?.player.stop()
                currentTrack?.player.currentTime = 0
                if let currentTrack = currentTrack {
                    if let currentIndex = tracks.firstIndex(of: currentTrack) {
                        self.currentTrack = tracks[currentIndex - 1]
                        return currentTrack
                    }
                }
            }
            return nil
            
        case .loop:
            if !isCurrentTrackFirst(){
                currentTrack?.player.stop()
                currentTrack?.player.currentTime = 0
                if let currentTrack = currentTrack {
                    if let currentIndex = tracks.firstIndex(of: currentTrack) {
                        self.currentTrack = tracks[currentIndex - 1]
                        return currentTrack
                    }
                }
            }
            if let last = tracks.last {
                currentTrack?.player.stop()
                currentTrack?.player.currentTime = 0
                currentTrack = last
            }
        case .repeateOne:
            currentTrack?.player.stop()
            currentTrack?.player.currentTime = 0
        }
        return currentTrack
    }
    
    

    
}
