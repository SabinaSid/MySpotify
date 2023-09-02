//
//  Playlist.swift
//  MySpotify
//
//  Created by Sabina Grinenko on 29.08.2023.
//

import UIKit

enum RepeateState {
    case off
    case on
    case repeateOne
}

class Playlist: NSObject {
    var tracks: [Track]
    var currentTrack: Track?
    var repeateState =  RepeateState.off
    
    init(tracks: [Track] = [], currentTrack: Track? = nil, repeateState: RepeateState = .off) {
        self.tracks = tracks
        self.currentTrack = currentTrack
        self.repeateState = repeateState
    }
    
    init(tracks: [Track] = []) {
        self.tracks = tracks
    }
    

    
}
