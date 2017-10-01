//
//  NewTweetViewController.swift
//  03 Tweeter
//
//  Created by YingYing Zhang on 9/30/17.
//  Copyright © 2017 Hearsay Systems. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController, UITextViewDelegate {

    var user: User!
    var tweet: Tweet!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetAuthorNameLabel: UILabel!
    @IBOutlet weak var tweetHandleLabel: UILabel!
    @IBOutlet weak var newTweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newTweetTextView.delegate = self
        
        let user = User.currentUser
        
        if user!.profileUrl != nil {
            profileImageView.setImageWith((user?.profileUrl!)!)
        } else {
            profileImageView.image = UIImage(named:"bizimage-small.png")
        }
        
        tweetAuthorNameLabel.text = user!.name
        tweetHandleLabel.text = user!.screenname
        
        
        newTweetTextView.text = ""
        //newTweetTextView.textColor = UIColor.lightGray
        
        
        newTweetTextView.becomeFirstResponder()
        newTweetTextView.selectedTextRange = newTweetTextView.textRange(from: newTweetTextView.beginningOfDocument, to: newTweetTextView.beginningOfDocument)
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onTweetButton(_ sender: Any) {
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImageView?.layer.cornerRadius = 3
        profileImageView?.clipsToBounds = true
    }
    /*
    func newTweetTextViewDidBeginEditing(_ textView: UITextView) {
        if newTweetTextView.textColor == UIColor.lightGray {
            newTweetTextView.text = nil
            newTweetTextView.textColor = UIColor.black
        }
    }
    
    func newTweetTextViewDidEndEditing(_ textView: UITextView) {
        if newTweetTextView.text.isEmpty {
            newTweetTextView.text = "What's happening?"
            newTweetTextView.textColor = UIColor.lightGray
        }
    }*/
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if newTweetTextView.textColor == UIColor.lightGray {
                newTweetTextView.selectedTextRange = newTweetTextView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    
    /*
    func newTweetTextView (_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText = newTweetTextView.text as NSString
        let updatedText = currentText.replacingCharacters(in: range as NSRange, with: text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            newTweetTextView.text = "Placeholder"
            newTweetTextView.textColor = UIColor.lightGray
            
            newTweetTextView.selectedTextRange = newTweetTextView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            
            return false
        }
            
            // Else if the text view's placeholder is showing and the
            // length of the replacement string is greater than 0, clear
            // the text view and set its color to black to prepare for
            // the user's entry
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
        return true
    }
 */
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
