//  RecorderController.swift
//  UniAid
//
//  Created by Cameron Trotter on 12/03/2016.
//  Copyright © 2016 igor epshtein. All rights reserved.
//

import AVFoundation
import UIKit

class RecorderController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    
    @IBOutlet weak var RecordButton: UIButton!
    @IBOutlet weak var PlayButton: UIButton!
    @IBOutlet var open: UIBarButtonItem!
    
    var soundRecorder :  AVAudioRecorder!
    var soundPlayer : AVAudioPlayer!
    var fileName = "audioFile.m4a"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Allows for the inclusion of the Navigation Menu
        open.target = self.revealViewController()
        open.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // Gets Directory for storing the audio file
    func getCacheDirectory() -> String{
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        return paths[0]
    }
    
    // Gets the audio file URL from the Directory
    func getFileURL() -> NSURL{
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent(fileName)
        return path
    }
    
    // Settings for the recorder: Format, Encoding, Quality, Bit Rate; sets to record
    func setRecorder(){
        let recordSettings : [String : AnyObject] = [AVFormatIDKey : NSNumber(unsignedInt : kAudioFormatAppleLossless), AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue as NSNumber, AVEncoderBitRateKey : 320000 as NSNumber, AVNumberOfChannelsKey : 2 as NSNumber, AVSampleRateKey : 44100.0 as NSNumber ]
        do{
            soundRecorder = try AVAudioRecorder(URL: getFileURL(), settings: recordSettings)
            soundRecorder.delegate = self
            soundRecorder.prepareToRecord()
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    // Record Button
    @IBAction func Record(sender: UIButton){
        // When Record button is hit, start recording, change to Stop, disable Play Button
        if sender.titleLabel?.text == "Record"{
            setRecorder()
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
            RecordButton.enabled = true
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
    
}