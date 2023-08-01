//
//  ItemTrackViewController.swift
//  MySpotify
//
//  Created by Sabina Grinenko on 26.07.2023.
//

import UIKit

class ItemTrackView: UIView {
    let trackNameLabel = UILabel()
    let coverImage = UIImageView()
    let durationLabel = UILabel()
    let artistNameLabel = UILabel ()
    
    let pinkColor = UIColor(red: 254/255, green: 1/255, blue: 169/255, alpha: 0.9)
    let yellowColor = UIColor(red: 246/255, green: 195/255, blue: 82/255, alpha: 0.9)
    let blueColor = UIColor(red: 107/255, green: 167/255, blue: 229/255, alpha: 1.0)
    let lilacColor = UIColor(red: 204/255, green: 103/255, blue: 199/255, alpha: 1.0)
    let grayColor = UIColor(red: 45/255, green: 49/255, blue: 52/255, alpha: 1.0)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setupUI() {
        //setup coverImage
        coverImage.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        coverImage.contentMode = .scaleAspectFit
        coverImage.clipsToBounds = true
        coverImage.backgroundColor = nil
        coverImage.tintColor = pinkColor
        coverImage.isUserInteractionEnabled = true
        coverImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(coverImage)
        
        //setup trackNameLabel
        trackNameLabel.textAlignment = .right
        trackNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        trackNameLabel.textColor = UIColor.white
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(trackNameLabel)
        
        //setup durationLabel
        durationLabel.textAlignment = .left
        durationLabel.font = UIFont.systemFont(ofSize: 17)
        durationLabel.textColor = UIColor.white
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(durationLabel)
        
        //setup artistNameLabel
        artistNameLabel.textAlignment = .right
        artistNameLabel.font = UIFont.systemFont(ofSize: 12)
        artistNameLabel.textColor = UIColor.lightGray
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(artistNameLabel)
        
        NSLayoutConstraint.activate([
            coverImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImage.topAnchor.constraint(equalTo: topAnchor),
            coverImage.widthAnchor.constraint(equalToConstant: 80),
            coverImage.heightAnchor.constraint(equalToConstant: 80),
            
            trackNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: coverImage.bounds.height/4),
            trackNameLabel.leadingAnchor.constraint(equalTo: coverImage.leadingAnchor, constant: coverImage.bounds.width + 4),
            
            artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 4),
            artistNameLabel.leadingAnchor.constraint(equalTo: coverImage.leadingAnchor, constant: coverImage.bounds.width + 4),
            artistNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            durationLabel.topAnchor.constraint(equalTo: topAnchor, constant: coverImage.bounds.height/3),
            durationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    func configure(track: Track) {
        if let coverImage = track.coverImage {
            self.coverImage.image = coverImage
        } else {
            coverImage.image = UIImage(systemName: "music.note")
            coverImage.contentMode = .scaleAspectFit
            coverImage.backgroundColor = nil
            coverImage.tintColor = pinkColor
            addGradientBackground(to: coverImage, colors: [pinkColor, yellowColor])
        }
        
        trackNameLabel.text = track.name
        artistNameLabel.text = track.artist
        durationLabel.text = track.player.duration.formatted()
        
    }
    
    func addGradientBackground(to view: UIView, colors: [UIColor], locate: (stat: CGPoint, end: CGPoint)? = nil, locations: [NSNumber]? = nil) -> CAGradientLayer {

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.frame = view.bounds
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        if let locate = locate {
            gradientLayer.startPoint = locate.stat
            gradientLayer.endPoint = locate.end
        }
        
        if let locate = locations {
            gradientLayer.locations = locate
        }
        
        view.layer.addSublayer(gradientLayer)
        return gradientLayer
    }
        
    
}
