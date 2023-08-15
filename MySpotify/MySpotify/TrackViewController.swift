//
//  TrackViewController.swift
//  MySpotify
//
//  Created by Sabina Grinenko on 26.07.2023.
//

import UIKit


class TrackViewController: UIViewController {
    
    let pinkColor = UIColor(red: 254/255, green: 1/255, blue: 169/255, alpha: 0.9)
    let yellowColor = UIColor(red: 246/255, green: 195/255, blue: 82/255, alpha: 0.9)
    let blueColor = UIColor(red: 107/255, green: 167/255, blue: 229/255, alpha: 1.0)
    let lilacColor = UIColor(red: 204/255, green: 103/255, blue: 199/255, alpha: 1.0)
    let grayColor = UIColor(red: 45/255, green: 49/255, blue: 52/255, alpha: 1.0)
    
    let coverImage = UIImageView()
    let gradientView = UIView()
    let viewTitle = UILabel()
    let trackNameLabel = UILabel()
    let artistNameLabel = UILabel()
    let slider =  UISlider()
    let playButton = UIButton(type: .system)
    
    
    var track: Track! //= Track(name: "City", artist: "Oxxxymiron", audioResource: "oxxxymiron")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientView.frame = view.bounds

        // Create custom gradient layer for the first two colors (horizontal)
        let horizontalGradientLayer = addGradientBackground(to: gradientView, colors: [pinkColor,yellowColor], locate: (CGPoint(x: 0.0, y: 0.0),CGPoint(x: 1.0, y: 0.0)))
        
        // Create custom gradient layer for the third color (vertical)
        let verticalGradientLayer = addGradientBackground(to: gradientView, colors: [UIColor.clear,grayColor], locate: (CGPoint(x: 0.3, y: 0.0),CGPoint(x: 0.3, y: 1.0)), locations: [0.0,0.8, 1.0])
        
        verticalGradientLayer.colors = [horizontalGradientLayer.colors as Any, grayColor.cgColor]
        
        view.backgroundColor = grayColor
        view.addSubview(gradientView)
        
        viewTitle.text = "Now Playing"
        viewTitle.textAlignment = .center
        viewTitle.font = UIFont.boldSystemFont(ofSize: 17)
        viewTitle.textColor = UIColor.white
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewTitle)
        
        coverImage.frame = CGRect(x: 0, y: 0, width: 350, height: 350)
        coverImage.contentMode = .scaleAspectFit
        coverImage.backgroundColor = nil
        coverImage.translatesAutoresizingMaskIntoConstraints = false
        
        if let image = track.coverImage {
            coverImage.image = image
        } else {
            coverImage.image = UIImage(systemName: "music.note")
            coverImage.tintColor = pinkColor
            addGradientBackground(to: coverImage, colors: [pinkColor, yellowColor])
        }
                
        view.addSubview(coverImage)
        
        trackNameLabel.text = track.name
        trackNameLabel.textAlignment = .center
        trackNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        trackNameLabel.textColor = UIColor.white
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(trackNameLabel)
        
        artistNameLabel.text = track.artist
        artistNameLabel.textAlignment = .center
        artistNameLabel.font = UIFont.systemFont(ofSize: 17)
        artistNameLabel.textColor = UIColor.lightGray
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(artistNameLabel)
        
        
        slider.minimumValue = 0
        slider.maximumValue = Float(track.player.duration)
        slider.value = 0
        
        slider.addTarget(self, action: #selector(sliderTouch(_:)), for: .allTouchEvents)
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slider)
        
        
        if let playImage = UIImage(systemName: "play.fill") {
            playButton.setImage(playImage, for: .normal)
        }
        playButton.tintColor = UIColor.white
        playButton.addTarget(self, action: #selector(playButtonTouch(_:)), for: .touchUpInside)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playButton)
        
        
        
        NSLayoutConstraint.activate([
            viewTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            viewTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            coverImage.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 32),
            coverImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coverImage.widthAnchor.constraint(equalToConstant: coverImage.bounds.width),
            coverImage.heightAnchor.constraint(equalToConstant: coverImage.bounds.height),
            
            trackNameLabel.topAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: 32),
            trackNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 8),
            artistNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            slider.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 32),
            slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slider.widthAnchor.constraint(equalToConstant: 350),
            
            playButton.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 8),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 50),
            playButton.heightAnchor.constraint(equalToConstant: 50)
            
            
        ])
    }
    
    @objc func sliderTouch(_ sender: UISlider) {
        track.player.currentTime = TimeInterval(sender.value)
    }
    
    @objc func playButtonTouch(_ sender: UIButton) {
        
        if track.player.isPlaying {
            if let playImage = UIImage(systemName: "play.fill") {
                playButton.setImage(playImage, for: .normal)
                track.player.stop()
            }
        } else {
            if let playImage = UIImage(systemName: "stop.fill") {
                playButton.setImage(playImage, for: .normal)
                track.player.play()
            }
        }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
