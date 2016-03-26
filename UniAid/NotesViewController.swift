//  NotesViewController.swift
//  NotesTest
//
//  Created by Cameron Trotter on 24/03/2016.
//  Copyright © 2016 Cameron Trotter. All rights reserved.
//

import UIKit
import AVFoundation

protocol NoteViewDelegate {
    func didUpdateNoteWithTitle(newTitle : String, andBody newBody :
        String)
}

class NotesViewController: UIViewController, UITextViewDelegate, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    //For the Notes
    var delegate : NoteViewDelegate?
    @IBOutlet weak var txtBody : UITextView!
    @IBOutlet weak var btnDoneEditing: UIBarButtonItem!
    var strBodyText : String!
    
    //For the Recorder
    @IBOutlet weak var RecordButton: UIButton!
    @IBOutlet weak var PlayButton: UIButton!
    var soundRecorder :  AVAudioRecorder!
    var soundPlayer : AVAudioPlayer!
    var fileName = "audioFile.m4a"
    
    //MARK: General Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set text to String
        self.txtBody.text = self.strBodyText
        //Open keyboard right away
        self.txtBody.becomeFirstResponder()
        //Allows UITextView methods to be called
        self.txtBody.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //If not NIL update item
        if self.delegate != nil {
            self.delegate!.didUpdateNoteWithTitle(
                self.navigationItem.title!, andBody: self.txtBody.text)
        }
    }
    
    //MARK: Notes Functions
    
    //Sets the color of the Hide Keyboard button when keyboard is up
    func textViewDidBeginEditing(textView: UITextView) {
        self.btnDoneEditing.tintColor = UIColor(red: 255.0/255.0, green:
            205.0/255.0, blue: 096.0/255.0, alpha: 1) 
    }
    
    //Set title for note
    func textViewDidChange(textView: UITextView) {
        //Separate the body into multiple sections
        let components = self.txtBody.text.componentsSeparatedByString("\n")
        //Reset the title to blank if no text
        self.navigationItem.title = ""
        //Loop through each String in the components array
        for item in components {
            if components.count > 0 {
                //Set title to update when typing
                self.navigationItem.title = item
                break
            }
        }
    }
    
    @IBAction func doneEditingBody() {
        //Hides the keyboard
        self.txtBody.resignFirstResponder()
        //Makes Hide Keyboard button invisible
        self.btnDoneEditing.tintColor = UIColor.clearColor()
        //If not NIL update item
        if self.delegate != nil {
            self.delegate!.didUpdateNoteWithTitle( self.navigationItem.title!, andBody: self.txtBody.text)
        }
    }
    
    //MARK: Recorder Functions
    
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
