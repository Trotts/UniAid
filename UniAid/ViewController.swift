//
//  ViewController.swift
//  UniAid
//
//  Created by igor epshtein on 2016-02-10.
//  Copyright © 2016 igor epshtein. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet var open: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        open.target = self.revealViewController()
        open.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
  }

    // Record Button
    @IBAction func Record(sender: UIButton){
        // When Record button is hit, start recording, change to Stop, disable Play Button
        if sender.titleLabel?.text == "Record"{
            soundRecorder.record()
            sender.setTitle("Stop", forState: .Normal)
            PlayButton.enabled = false
        }
        // When button is "Stop" and hit, stop recording, set to record, enable play
        else{
            soundRecorder.stop()
            sender.setTitle("Record", forState: .Normal)
            PlayButton.enabled = false
        }
    }
    
    //Play Button
    @IBAction func PlayRecord(sender: UIButton){
        // When Play button is hit, start playing file, change to Stop, disable Record Button
        if sender.titleLabel?.text == "Play"{
            RecordButton.enabled = false
            sender.setTitle("Stop", forState: .Normal)
            preparePlayer()
            soundPlayer.play()
        }
        // When button is "Stop" and hit, stop playing, set to Play
        else{
            soundPlayer.stop()
            sender.setTitle("Play", forState: .Normal)
        }
    }
    
    // Sets up the Audio Player
    func preparePlayer(){
        do{
            soundPlayer =  try AVAudioPlayer(contentsOfURL: getFileURL())
            soundPlayer.delegate = self
            soundPlayer.prepareToPlay()
            soundPlayer.volume = 1.0
            
        }
        catch let error as NSError{
            print(error.localizedDescription)

        }
    }
    // When Recording is finished, enable Play Button
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        PlayButton.enabled = true
    }
    // When Audio Player is finished, enable Record Button
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        RecordButton.enabled = true
        PlayButton.setTitle("Play", forState: .Normal)
    }
    
    //END RECORDER FUNCTIONS - Cameron
    
}


