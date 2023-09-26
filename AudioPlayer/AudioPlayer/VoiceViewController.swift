//
//  VoiceViewController.swift
//  AudioPlayer
//
//  Created by Никита on 25.09.2023.
//

import UIKit
import AVFoundation

class VoiceViewController: UIViewController {
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    var session = AVAudioSession.sharedInstance()
    var player: AVAudioPlayer?
    var recorder: AVAudioRecorder?
    var isRecording = false
    var isPlaying = false
    var accessGranted = false
    let fileName = "voiceRecord.m4a"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPermission()
        
    }
    
    private func audioPermission() {
        // Для использования микрофона
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            DispatchQueue.main.async {
                if granted {
                    self.accessGranted = true
                    print("Доступ разрешён")
                    self.view.backgroundColor = .gray
                } else {
                    self.view.backgroundColor = .red
                    print("Доступ НЕ разрешён")
                }
            }
        }
    }
    
    @IBAction func recordButtonAction(_ sender: UIButton) {
        if isRecording {
            stopRecorder()
            view.backgroundColor = .gray
        } else {
            startRecorder()
            view.backgroundColor = .white
        }
    }
    
    @IBAction func playButtonAction(_ sender: UIButton) {
        playSound(nameTrack: fileName)
    }
    
    private func getFileUrl(name: String) -> URL {
        return (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(name))!
    }
    
    func playSound(nameTrack: String) {
        //guard let path = Bundle.main.path(forResource: nameTrack, ofType: "m4a") else {return}
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        print(url.absoluteString)
        do {
            player = try AVAudioPlayer(contentsOf: url.appendingPathComponent(nameTrack))
            player?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // DCdcdf
    func startRecorder() {
        if accessGranted {
            do {
                try session.setCategory(.playAndRecord, mode: .default)
                try session.setActive(true)
                let settings = [
                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 44100,
                    AVNumberOfChannelsKey: 2,
                    AVEncoderAudioQualityKey:AVAudioQuality.high.rawValue
                ]
                recorder = try AVAudioRecorder(url: getFileUrl(name: fileName), settings: settings)
                print(getFileUrl(name: fileName).absoluteString)
                recorder?.delegate = self
                recorder?.isMeteringEnabled = true
                recorder?.record()
                recordButton.setTitle("Stop", for: .normal)
                isRecording = true
            }
            catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Please give access to the microphone")
        }
    }
    
    func stopRecorder() {
        recorder?.stop()
        recorder = nil
        isRecording = false
        recordButton.setTitle("Record", for: .normal)
    }
    
}

extension VoiceViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            playSound(nameTrack: fileName)
        }
    }
}


