//
//  ViewController.swift
//  MySpotify
//
//  Created by Sabina Grinenko on 20.07.2023.
//

import UIKit

class ViewController: UIViewController {

    var coverImage = UIImageView()
    var topBackgroundGradientView = UIView()
    var bottomBackgroundGradientView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pinkColor = UIColor(red: 254/255, green: 1/255, blue: 169/255, alpha: 0.9)
        let yellowColor = UIColor(red: 246/255, green: 195/255, blue: 82/255, alpha: 0.9)
        let blueColor = UIColor(red: 107/255, green: 167/255, blue: 229/255, alpha: 1.0)
        let lilacColor = UIColor(red: 204/255, green: 103/255, blue: 199/255, alpha: 1.0)
        let grayColor = UIColor(red: 45/255, green: 49/255, blue: 52/255, alpha: 1.0)
 
    
        
        coverImage.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        coverImage.center = view.center
        coverImage.image = UIImage(systemName: "music.note")
        coverImage.contentMode = .scaleAspectFit
        coverImage.backgroundColor = nil
        coverImage.tintColor = pinkColor
        
        addGradientBackground(to: coverImage, colors: [pinkColor, yellowColor], locate: (CGPoint(x: 0, y: 0),CGPoint(x: 1, y: 1)))
        
        topBackgroundGradientView.frame = CGRect(x: view.bounds.minX, y: view.bounds.minY, width: view.bounds.width, height: view.bounds.maxY/3)
        
        bottomBackgroundGradientView.frame = CGRect(x: view.bounds.minX, y: view.bounds.maxY/3, width: view.bounds.width, height: view.bounds.maxY/8)
        
        addGradientBackground(to: topBackgroundGradientView, colors: [blueColor, lilacColor], locate: (CGPoint(x: 0, y: 0),CGPoint(x: 1, y: 0)),locations: [0.0, 1.0])
        
        addGradientBackground(to: bottomBackgroundGradientView, colors: [lilacColor,grayColor], locate: (CGPoint(x: 0, y: 0),CGPoint(x: 0, y: 1)), locations: [0.0,1.0])
        
        
        view.backgroundColor =  grayColor
        view.addSubview(topBackgroundGradientView)
        view.addSubview(bottomBackgroundGradientView)
        
        
       
        
        view.addSubview(coverImage)
        
        
        // Do any additional setup after loading the view.
    }
    
    func addGradientBackground(to view: UIView, colors: [UIColor], locate: (stat: CGPoint, end: CGPoint)? = nil, locations: [NSNumber]? = nil) {

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.frame = view.bounds
        gradientLayer.locations = [0.0, 1.0]
        
        if let locate = locate {
            gradientLayer.startPoint = locate.stat
            gradientLayer.endPoint = locate.end
        }
        
        if let locate = locations {
            gradientLayer.locations = locate
        }
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    


}

