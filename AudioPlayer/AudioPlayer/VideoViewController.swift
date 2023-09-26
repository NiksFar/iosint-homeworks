//
//  VideoViewController.swift
//  AudioPlayer
//
//  Created by Никита on 25.09.2023.
//

import UIKit
import WebKit

class VideoViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    let stringURL = "https://www.youtube.com/watch?v=gW5SGoMnZnU&t=129s"
    
    let videoID = "cgYMtuFa8Iw"
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // startVideo(fromURL: stringURL)
        startYouTubeVideo(videoID: videoID)
    }
    
    private func startVideo(fromURL: String) {
        let url = URL(string: fromURL)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    private func startYouTubeVideo(videoID: String) {
        let url = URL(string: "https://www.youtube.com/embed/\(videoID)")
        let request = URLRequest(url: url!)
        webView.load(request)
    }



}
