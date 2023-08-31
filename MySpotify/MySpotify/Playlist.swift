//
//  Playlist.swift
//  MySpotify
//
//  Created by Sabina Grinenko on 29.08.2023.
//

import UIKit

class Playlist: NSObject {
    var tracks: [Track]
    var currentTrack: Track?
    
    init(tracks: [Track] = [], currentTrack: Track? = nil) {
        self.tracks = tracks
        self.currentTrack = currentTrack
        
        
    }
    

    
}
