//
//  MusicViewController.swift
//  SwiftBootcamp
//
//  Created by Manish Sharma on 19/01/19.
//  Copyright © 2019 Manish Sharma. All rights reserved.
//

import UIKit
import AVFoundation

class MusicViewController: UIViewController, AVAudioPlayerDelegate {

    var audioPlayer: AVAudioPlayer?
    var selectedNote = ""
    let musicArr = ["note1","note2","note3","note4","note5","note6","note7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        audioPlayer?.delegate = self
    }

    @IBAction func musicButtonPressed(_ sender: UIButton) {
        selectedNote = musicArr[sender.tag - 1]
        playSound()
    }
    
    func playSound() {
        let soundUrl = Bundle.main.url(forResource: selectedNote, withExtension: "wav")
     
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundUrl!)
        } catch {
            print(error)
        }
        audioPlayer?.play()
    }
}
