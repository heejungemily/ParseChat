//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Emily Heejung Son on 2/22/18.
//  Copyright © 2018 Emily Heejung Son. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource {
   
  
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var chatMessageField: UITextField!
    
    var messages : [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        tableView.estimatedRowHeight = 50
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.queryMessages), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func sendMessage(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")

        chatMessage["text"] = chatMessageField.text ?? ""
        chatMessage["user"] = PFUser.current()

        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.chatMessageField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
        
    }
 
    
    @objc func queryMessages() {
        var query = Message.query()
        query?.addDescendingOrder("createdAt")
        query?.includeKey("user")
        
        query?.findObjectsInBackground(block: { (object, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else if let messages = object as? [Message] {
                self.messages = messages
                self.tableView.reloadData()
            }
        })
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let message = messages[indexPath.row]
        cell.messageLabel.text = message.text
        if let user = message["user"] as? PFUser {
            // User found! update username label with username
            cell.usernameLabel.text = user.username
        } else {
            // No user found, set default username
            cell.usernameLabel.text = "🤖"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
