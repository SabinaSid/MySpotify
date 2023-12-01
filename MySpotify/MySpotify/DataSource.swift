//
//  DataSource.swift
//  MySpotify
//
//  Created by Sabina Grinenko on 29.08.2023.
//

import UIKit

class DataSource: NSObject {
  var playlist = Playlist()
    let imageGorgorod = UIImage(named: "Gorgorod")
    let imageGangsta = UIImage(named: "Gangsta")
    
    init(playlist: Playlist = Playlist()) {
        self.playlist = playlist
        playlist.tracks.append(Track(name: "On the Other Side", artist: "Oxxxymiron", audioResource: "oxxxymiron", coverImage: imageGorgorod ))
        playlist.tracks.append(Track(name: "Gangsta's Paradise", artist: "Coolio", audioResource: "Gangsta paradise", coverImage: imageGangsta))
        playlist.tracks.append(Track(name: "Gangsta!!!", artist: "Third element", audioResource: "Gangsta paradise"))
    }
}
