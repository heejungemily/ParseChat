//
//  Message.swift
//  ParseChat
//
//  Created by Emily Heejung Son on 2/22/18.
//  Copyright © 2018 Emily Heejung Son. All rights reserved.
//

import UIKit
import Parse

class Message: PFObject, PFSubclassing {
    @NSManaged var text : String
    @NSManaged var user : PFUser
    
    
    /* Needed to implement PFSubclassing interface */
    class func parseClassName() -> String {
        return "Message"
    }

}
