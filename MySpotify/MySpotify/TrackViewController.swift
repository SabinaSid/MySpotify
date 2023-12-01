//
//  TrackViewController.swift
//  MySpotify
//
//  Created by Sabina Grinenko on 26.07.2023.
//

import UIKit

class TrackViewController: UIViewController {
    
    let coverImage = UIImageView()
    let gradientView = UIView()
    let viewTitle = UILabel()
    let trackNameLabel = UILabel()
    let artistNameLabel = UILabel()
    let slider =  UISlider()
    let playButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    let backButton = UIButton(type: .system)
    let repeatButton = UIButton(type: .system)
    let currentTimeLabel = UILabel()
    let timeToEndLabel = UILabel()
    
    var playlist: Playlist!
    var track: Track!
    var timer: Timer?
    
    //TODO: Add images to tracks, round image
    //TODO: ALMOST Store a state of track to can dismiss modal window with track and see what track playing now
    //TODO: Add button to mix up tracks
    //TODO: Add button to share track
    //TODO: Get tracks using API
    //TODO: Add the ability to add a track
    //TODO: Follow some recommendations
    //TODO: Add the ability to scroll
    
    override func viewDidLoad() {
        super.viewDidLoad()
        track = playlist.currentTrack
        track.delegates.append(self)
                
        gradientView.frame = view.bounds

        // Create custom gradient layer for the first two colors (horizontal)
        let horizontalGradientLayer = addGradientBackground(to: gradientView, colors: [CustomColors.pinkColor,CustomColors.yellowColor], locate: (CGPoint(x: 0.0, y: 0.0),CGPoint(x: 1.0, y: 0.0)))
        
        // Create custom gradient layer for the third color (vertical)
        let verticalGradientLayer = addGradientBackground(to: gradientView, colors: [UIColor.clear,CustomColors.grayColor], locate: (CGPoint(x: 0.3, y: 0.0),CGPoint(x: 0.3, y: 1.0)), locations: [0.0,0.8, 1.0])
        
        verticalGradientLayer.colors = [horizontalGradientLayer.colors as Any, CustomColors.grayColor.cgColor]
        
        view.backgroundColor = CustomColors.grayColor
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
            coverImage.tintColor = CustomColors.pinkColor
            addGradientBackground(to: coverImage, colors: [CustomColors.pinkColor, CustomColors.yellowColor])
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
        
        currentTimeLabel.text = timeString(from: track.currentTime)
        currentTimeLabel.textAlignment = .left
        currentTimeLabel.font = UIFont.systemFont(ofSize: 12)
        currentTimeLabel.textColor = UIColor.lightGray
        currentTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(currentTimeLabel)
        
        slider.minimumValue = 0
        slider.maximumValue = Float(track.duration)
        slider.value = Float(track.currentTime)
        
        slider.addTarget(self, action: #selector(sliderTouch(_:)), for: .touchUpInside)
        slider.addTarget(self, action: #selector(sliderHold(_:)), for: .touchDragInside)
       
        // Запуск таймера с интервалом 1 секунда
       timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSliderUI), userInfo: nil, repeats: true)
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slider)
        
        timeToEndLabel.text = timeString(from: track.duration)
        timeToEndLabel.textAlignment = .left
        timeToEndLabel.font = UIFont.systemFont(ofSize: 12)
        timeToEndLabel.textColor = UIColor.lightGray
        timeToEndLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeToEndLabel)
        
        

        setPlayButtonImage()
        print (playlist.isPlaying, "viewDidLoad")
        playButton.tintColor = UIColor.white
        playButton.addTarget(self, action: #selector(playButtonTouch(_:)), for: .touchUpInside)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playButton)
        
        if let forwardImage = UIImage(systemName: "forward.end.fill") {
            nextButton.setImage(forwardImage, for: .normal)
        }
        nextButton.tintColor = UIColor.white
        nextButton.addTarget(self, action: #selector(nextButtonTouch(_:)), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        /*
        // if it's last track and repeat state is off, hide button
        if playlist.tracks.last === track && playlist.repeateState == .off {
            nextButton.isEnabled = false
        } else {nextButton.isEnabled = true}
         */
        view.addSubview(nextButton)
        
        if let backwardImage = UIImage(systemName: "backward.end.fill") {
            backButton.setImage(backwardImage, for: .normal)
        }
        backButton.tintColor = UIColor.white
        backButton.addTarget(self, action: #selector(backButtonTouch(_:)), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        if let repeatImage = UIImage(systemName: "repeat") {
            repeatButton.setImage(repeatImage, for: .normal)
        }
        repeatButton.tintColor = UIColor.white
        repeatButton.addTarget(self, action: #selector(repeatButtonTouch(_:)), for: .touchUpInside)
        repeatButton.translatesAutoresizingMaskIntoConstraints = false
        setImageOnRepeatButton()
        view.addSubview(repeatButton)
        
        

        
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
            slider.widthAnchor.constraint(equalToConstant: 310),
            
            currentTimeLabel.topAnchor.constraint(equalTo: slider.topAnchor, constant: 8),
            currentTimeLabel.leadingAnchor.constraint(equalTo: slider.leadingAnchor, constant: -35),
            
            timeToEndLabel.topAnchor.constraint(equalTo: slider.topAnchor, constant: 8),
            timeToEndLabel.trailingAnchor.constraint(equalTo: slider.trailingAnchor, constant: 35),
            
            playButton.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 8),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 50),
            playButton.heightAnchor.constraint(equalToConstant: 50),
            
            nextButton.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 8),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 42),
            nextButton.widthAnchor.constraint(equalToConstant: 50),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            backButton.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 8),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -42),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            
            repeatButton.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 8),
            repeatButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            repeatButton.widthAnchor.constraint(equalToConstant: 50),
            repeatButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        print ("viewDidLoad f")
    }
    
    @objc func sliderTouch(_ sender: UISlider) {
        playlist.rewindTo(newTime: TimeInterval(sender.value))
        currentTimeLabel.text = timeString(from: track.currentTime)
        timeToEndLabel.text = timeString(from: track.duration - track.currentTime)
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSliderUI), userInfo: nil, repeats: true)
    }
    
    @objc func sliderHold(_ sender: UISlider) {
        currentTimeLabel.text = timeString(from: TimeInterval(sender.value))
        timeToEndLabel.text = timeString(from: track.duration - TimeInterval(sender.value))
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimeLabelsUI), userInfo: nil, repeats: true)
    }
    

    func timeString(from timeInterval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad

        return formatter.string(from: timeInterval) ?? "0:00"
    }
    
    
    @objc func playButtonTouch(_ sender: UIButton) {
        playlist.play()
        setPlayButtonImage()
    }
    
    func setPlayButtonImage()  {
        
        if playlist.isPlaying {
            if let playImage = UIImage(systemName: "stop.fill") {
                playButton.setImage(playImage, for: .normal)
                return
            }
        }
       
        if let playImage = UIImage(systemName: "play.fill") {
                playButton.setImage(playImage, for: .normal)
        }
    }
    
    @objc func nextButtonTouch(_ sender:UIButton) {
        if let _ = playlist.next() {
            changeTrack()
        }
    }
    
    @objc func backButtonTouch(_ sender:UIButton) {
        if let _ = playlist.back() {
            changeTrack()
        }
    }
    
    @objc func repeatButtonTouch(_ sender:UIButton) {
        playlist.changeRepeateState()
        setImageOnRepeatButton()
    }
    
    func setImageOnRepeatButton(){
        switch playlist.repeateState {
        case .off:
            if let repeatImage = UIImage(systemName: "repeat") {
                repeatButton.setImage(repeatImage, for: .normal)
            }
            repeatButton.tintColor = UIColor.white
        case .loop:
            if let repeatImage = UIImage(systemName: "repeat") {
                repeatButton.setImage(repeatImage, for: .normal)
            }
            repeatButton.tintColor = UIColor.green
        case .repeatOne:
            if let repeatImage = UIImage(systemName: "repeat.1") {
                repeatButton.setImage(repeatImage, for: .normal)
            }
            repeatButton.tintColor = UIColor.green
        }
    }
    
    func changeTrack() {
        timer?.invalidate()
        viewDidLoad()
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
    
    @objc func updateSliderUI() {
        if playlist.isPlaying{
        slider.setValue(Float(track.currentTime), animated: true)
        currentTimeLabel.text = timeString(from: track.currentTime)
        timeToEndLabel.text = timeString(from: track.duration - track.currentTime)
        }
    }
    
    @objc func updateTimeLabelsUI() {
        
        if playlist.isPlaying{
        currentTimeLabel.text = timeString(from: track.currentTime)
        timeToEndLabel.text = timeString(from: track.duration - track.currentTime)
        }
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

extension TrackViewController: TrackDelegete {
    func didChangeState(newState: TrackState) {
        //ignore
    }
    
    func didFinishPlaying() {
        if let _ = playlist.next() {
            changeTrack()
            return
        }
        setPlayButtonImage()
    }
}
