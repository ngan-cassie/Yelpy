//
//  ChatViewController.swift
//  Yelpy
//
//  Created by Hieu Ngan Nguyen on 4/20/22.
//  Copyright © 2022 memo. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {

    
    @IBOutlet weak var chatView: UITableView!
    
    @IBOutlet weak var messageTextField: UITextField!
    
    // CREATE ARRAY FOR MESSAGES
    var messages: [PFObject] = []
    
    // CREATE CHAT MESSAGE OBJECT
    let chatMessage = PFObject(className: "Message")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        chatView.dataSource = self
        chatView.delegate = self
        
        chatView.rowHeight = UITableView.automaticDimension
        chatView.estimatedRowHeight = 50
        
        // Reload messages every second (interval of 1 second)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.loadChats), userInfo: nil, repeats: true)
        chatView.reloadData()
    }
    
    @objc func loadChats() {
        let query = PFQuery(className: "Message")
        query.includeKeys(["user","text"])
        query.limit = 20
        query.findObjectsInBackground{
            (messages, error) in
            
            if let messages = messages {
                self.messages = messages
                self.chatView.reloadData()
            } else {
                print(error!.localizedDescription)            }
        }
    }

    @IBAction func onSend(_ sender: Any) {
        if messageTextField.text!.isEmpty == false {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = messageTextField.text ?? ""
        chatMessage["user"] = PFUser.current()!
        chatMessage.saveInBackground { (success, error) in
           if success {
              print("The message was saved!")
               self.messageTextField.text = ""
           } else if let error = error {
              print("Problem saving message: \(error.localizedDescription)")
           }
        }
        } else {
            print("\nMessage cannot be empty\n")
        }
        
    }
    
    @IBAction func onLogout(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // NOTE: Don't worry about the error, please follow the lab!
        return messages.count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell

        let message = messages[indexPath.row]
        cell.messageLabel.text = message["text"] as? String
        
        // set the username
        if let user = message["user"] as? PFUser {
            cell.usernameLabel.text = user.username
        } else {
            cell.usernameLabel.text = "?"
        }

        return cell
    }


}
