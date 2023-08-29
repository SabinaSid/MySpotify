//
//  DataSource.swift
//  MySpotify
//
//  Created by Sabina Grinenko on 29.08.2023.
//

import UIKit

class DataSource: NSObject {
  var playlist = Playlist()
    
    init(playlist: Playlist = Playlist()) {
        self.playlist = playlist
        playlist.tracks.append(Track(name: "City", artist: "Oxxxymiron", audioResource: "oxxxymiron"))
        playlist.tracks.append(Track(name: "Gangsta's Paradise", artist: "Coolio", audioResource: "Gangsta paradise"))
        playlist.tracks.append(Track(name: "Gangsta!!!", artist: "Third element", audioResource: "Gangsta paradise"))
    }
}
