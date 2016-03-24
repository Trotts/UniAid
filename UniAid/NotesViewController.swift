//
//  NotesViewController.swift
//  NotesTest
//
//  Created by Cameron Trotter on 24/03/2016.
//  Copyright © 2016 Cameron Trotter. All rights reserved.
//

import UIKit
//Test

protocol NoteViewDelegate {
    func didUpdateNoteWithTitle(newTitle : String, andBody newBody :
        String)
}

class NotesViewController: UIViewController, UITextViewDelegate {
    
    var delegate : NoteViewDelegate?
    @IBOutlet weak var txtBody : UITextView!
    @IBOutlet weak var btnDoneEditing: UIBarButtonItem!
    var strBodyText : String!
    
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
    
    func textViewDidBeginEditing(textView: UITextView) {
        //Sets the color of the Hide Keyboard button when keyboard is up
        self.btnDoneEditing.tintColor = UIColor(red: 255.0/255.0, green:
            205.0/255.0, blue: 096.0/255.0, alpha: 1) 
    }
    
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
}
