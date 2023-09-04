//
//  ViewController.swift
//  MySpotify
//
//  Created by Sabina Grinenko on 20.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var gradientView = UIView()
    var verticalStackView = UIStackView()
    var playList: Playlist!
    var dataSource = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pinkColor = UIColor(red: 254/255, green: 1/255, blue: 169/255, alpha: 0.9)
        let yellowColor = UIColor(red: 246/255, green: 195/255, blue: 82/255, alpha: 0.9)
        let blueColor = UIColor(red: 107/255, green: 167/255, blue: 229/255, alpha: 1.0)
        let lilacColor = UIColor(red: 204/255, green: 103/255, blue: 199/255, alpha: 1.0)
        let grayColor = UIColor(red: 45/255, green: 49/255, blue: 52/255, alpha: 1.0)
 
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = 32
        
        playList = dataSource.playlist
        
        for item in playList.tracks {
            viewTrack(item)
        }
   
        gradientView.frame = view.bounds

        // Create custom gradient layer for the first two colors (horizontal)
        let horizontalGradientLayer = addGradientBackground(to: gradientView, colors: [blueColor,lilacColor], locate: (CGPoint(x: 0.0, y: 0.0),CGPoint(x: 1.0, y: 0.0)))
        
        // Create custom gradient layer for the third color (vertical)
        let verticalGradientLayer = addGradientBackground(to: gradientView, colors: [UIColor.clear,grayColor], locate: (CGPoint(x: 0.3, y: 0.0),CGPoint(x: 0.3, y: 1.0)), locations: [0.0,0.5, 1.0])
        
        verticalGradientLayer.colors = [horizontalGradientLayer.colors as Any, grayColor.cgColor]
        view.backgroundColor =  grayColor
        view.addSubview(gradientView)
        view.addSubview(verticalStackView)
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.bounds.height/3),
                    verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                    verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
                ])

    }
    
    func viewTrack(_ track: Track)  {
        let itemTrackView = ItemTrackView()
        itemTrackView.configure(track: track)
        verticalStackView.addArrangedSubview(itemTrackView)
        
        // Adding tap gesture recognizer to the UIImageView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        itemTrackView.addGestureRecognizer(tapGesture)
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer)  {
        
        if let track = (sender.view as? ItemTrackView)?.track {
            if let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "TrackViewSB") as? TrackViewController {
                newViewController.playlist = playList
                playList.currentTrack = track
                newViewController.track = track
                self.present(newViewController, animated: true)
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
    
    


}

