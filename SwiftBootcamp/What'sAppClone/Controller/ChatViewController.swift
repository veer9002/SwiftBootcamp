//
//  ViewController.swift
//  Flash Chat
//
//  Created by Angela Yu on 29/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class ChatViewController: UIViewController {
    
    // Declare instance variables here
    var messageArray = [Message]()
    
    // We've pre-linked the IBOutlets
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    @IBOutlet weak var searchBar: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = UITableView.automaticDimension
        
        //TODO: Set yourself as the delegate of the text field here:
        messageTextfield.delegate = self
        
        //TODO: Set the tapGesture here:
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        
        retrieveData()
        
    }

    ///////////////////////////////////////////
    
    //TODO: Declare tableViewTapped here:
    @objc func tableViewTapped() {
        messageTextfield.endEditing(true)
    }

    //MARK: - Send & Receive from Firebase
    
    func retrieveData() {
        let cloudDB = Database.database().reference().child("Messages")
        
        cloudDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            print(text, sender)
          
            var message = Message()
            message.messageBody = text
            message.sender = sender
            
            self.messageArray.append(message)
            self.messageTableView.reloadData()
        }
    }
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        //TODO: Send the message to Firebase and save it in our database
        messageTextfield.endEditing(true)
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        
        let messageDatabase = Database.database().reference().child("Messages")
        let messageDict = ["Sender": Auth.auth().currentUser?.email,
                           "MessageBody": messageTextfield.text!]
        messageDatabase.childByAutoId().setValue(messageDict) {
            (error, reference) in
            if error != nil {
                print("Error \(error!)")
            } else {
                print("Saved successfully")
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextfield.text = ""
            }
        }
    }
    
    //TODO: Create the retrieveMessages method here:
    
    
    
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        //TODO: Log out the user and send them back to WelcomeViewController
        do {
            try Auth.auth().signOut()
            self.navigationController?.popViewController(animated: true)
        }
        catch {
            print("Error! Something wrong in sign out")
        }
    }
    
}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        cell.lblMessageBody.text = messageArray[indexPath.row].messageBody
        cell.lblSender.text = messageArray[indexPath.row].sender
        
        if cell.lblSender.text == Auth.auth().currentUser?.email {
            cell.messageBg.backgroundColor = UIColor.flatRed()
            cell.avatarImage.backgroundColor = UIColor.flatLime()
        } else {
            cell.messageBg.backgroundColor = UIColor.flatPink()
            cell.avatarImage.backgroundColor = UIColor.flatTeal()
        }
        return cell
    }
    
}

extension ChatViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.heightConstraint.constant = 358
            self.view.layoutIfNeeded()
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5, animations: {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        })
    }
  
}

