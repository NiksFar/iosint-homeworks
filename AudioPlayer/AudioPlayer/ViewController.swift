//  ViewController.swift
//  AudioPlayer
//
//  Created by Никита on 21.09.2023.

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var volumeLabel: UILabel!
    
    @IBOutlet weak var timeSlider: UISlider!
    
    @IBOutlet weak var volumeSlider: UISlider!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var songNameLabel: UILabel!
    
    var timer: Timer?
    var player: AVAudioPlayer?
    var trackNumber = 0
    var tracks: [String] = ["track01", "track02", "track03", "track04", "track05", "track06", "track07", "track08", "track09", "track10", "track11"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeSlider.minimumValue = 0
        timeSlider.value = 0
        volumeSlider.minimumValue = 0
        volumeSlider.maximumValue = 1
        volumeSlider.value = 0.5
        //playSound(nameTrack: tracks[trackNumber], currentTime: 0)
        print("didLoad")
    }
    
    @IBAction func playButtonAction(_ sender: UIButton) {
        guard let player = player else {
            // Если плеера нет - то это первый запуск
            playSound(nameTrack: tracks[trackNumber], currentTime: 0)
            sender.setTitle("Pause", for: .normal)
            return
        }
        if player.isPlaying {
            // Если песня есть и она воспроизводится
            player.pause()
            sender.setTitle("Play", for: .normal)
            timer?.invalidate()
        } else {
            // Если песня есть и она на паузе
            playSound(nameTrack: tracks[trackNumber], currentTime: timeSlider.value)
            sender.setTitle("Pause", for: .normal)
        }
    }
    
    @IBAction func stopButtonAction(_ sender: UIButton) {
        player?.stop()
        player?.currentTime = 0
        timer?.invalidate()
        timeSlider.value = 0
        timeLabel.text = "0 / \(Int(player?.duration ?? 0)) sec"
        playButton.setTitle("Play", for: .normal)
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        trackNumber -= 1
        if trackNumber <= 0 { trackNumber = 0}
        playSound(nameTrack: tracks[trackNumber], currentTime: 0)
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        trackNumber += 1
        if trackNumber >= tracks.count { trackNumber = 0}
        playSound(nameTrack: tracks[trackNumber], currentTime: 0)
    }
    
    @IBAction func timeSliderAction(_ sender: UISlider) {
        player?.stop()
        player?.currentTime = TimeInterval(sender.value)
        setupTimeSlider(timeIndex: sender.value)
        player?.play()
    }
    
    @IBAction func volumeSliderAction(_ sender: UISlider) {
        player?.volume = sender.value
        volumeLabel.text = "\(Int(sender.value * 100)) %"
    }
    
    @IBAction func randomButtonAction(_ sender: UIButton) {
        guard let randomSong = tracks.randomElement() else {return print("Error")}
        playSound(nameTrack: randomSong, currentTime: 0)
    }
    
    
    private func setupTimeSlider(timeIndex: Float) {
        timer?.invalidate()
        guard let player = player else {return}
        let time = player.duration
        timeSlider.maximumValue = Float(time)
        var index = timeIndex
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            index += 1
            self.timeLabel.text = "\(Int(index)) / \(Int(time)) sec"
            self.timeSlider.value = index
        })
    }
    
    func playSound(nameTrack: String, currentTime: Float) {
        timeSlider.value = currentTime
        guard let path = Bundle.main.path(forResource: "Track/\(nameTrack)", ofType: "mp3") else {return}
        songNameLabel.text = nameTrack
        let url = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.volume = volumeSlider.value
            player?.currentTime = TimeInterval(currentTime)
            setupTimeSlider(timeIndex: currentTime)
            player?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

extension ViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag == true {
            trackNumber += 1
            if trackNumber >= tracks.count {
                trackNumber = 0
                player.stop()
                return
            } else {
                playSound(nameTrack: tracks[trackNumber], currentTime: 0)
            }
        }
    }
}
