//
//  Track.swift
//  MySpotify
//
//  Created by Sabina Grinenko on 26.07.2023.
//

import UIKit
import AVFoundation

class Track: NSObject {
    var player = AVAudioPlayer()
    var name: String = "City"
    var artist: String = "oxxxymiron"
    var coverImage: UIImage?
    
    init(name: String, artist: String, audioResource: String, audioType: String = "mp3", coverImage: UIImage? = nil) {
        self.name = name
        self.artist = artist
        self.coverImage = coverImage
        
        do {
            if let audioPath = Bundle.main.path(forResource: audioResource, ofType: audioType){
                try player = AVAudioPlayer(contentsOf: URL(filePath: audioPath))
            }
            
        } catch {
            print("ERROR")
        }
    }
}
