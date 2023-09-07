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
    var playlist: Playlist!
    var dataSource = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = 32
        
        if playlist == nil {
            playlist = dataSource.playlist
        }
       
        
        for item in playlist.tracks {
            viewTrack(item)
        }
   
        gradientView.frame = view.bounds

        // Create custom gradient layer for the first two colors (horizontal)
        let horizontalGradientLayer = addGradientBackground(to: gradientView, colors: [CustomColors.blueColor,CustomColors.lilacColor], locate: (CGPoint(x: 0.0, y: 0.0),CGPoint(x: 1.0, y: 0.0)))
        
        // Create custom gradient layer for the third color (vertical)
        let verticalGradientLayer = addGradientBackground(to: gradientView, colors: [UIColor.clear,CustomColors.grayColor], locate: (CGPoint(x: 0.3, y: 0.0),CGPoint(x: 0.3, y: 1.0)), locations: [0.0,0.5, 1.0])
        
        verticalGradientLayer.colors = [horizontalGradientLayer.colors as Any, CustomColors.grayColor.cgColor]
        view.backgroundColor =  CustomColors.grayColor
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
                newViewController.playlist = playlist
                playlist.changeTrack(track: track)
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

