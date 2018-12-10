//
//  MessageFirebase.swift
//  ChatKeepcoding
//
//  Created by CRISTIAN ESPES on 10/12/2018.
//  Copyright © 2018 ERISCO. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class MessageFirebase: MessageManager {
    var discussion: Discussion
    var ref: DatabaseReference
    
    required init(discussion: Discussion) {
        self.discussion = discussion
        self.ref = Database.database().reference().child("messages").child(self.discussion.uid)
    }
    
    func list(onSuccess: @escaping ([Message]) -> Void, onError: ErrorClosure?) {
        self.ref.observe(.value, with: { (snapshot) in
            let messages = snapshot.children.compactMap({ Message.mapper(snapshot: $0 as! DataSnapshot) }).sorted(by: { $0.sentDate < $1.sentDate})
            
            onSuccess(messages)
        }) { (error) in
            if let retError = onError {
                retError(error)
            }
        }
    }
    
    func add(message: Message, onSuccess: @escaping () -> Void, onError: ErrorClosure?) {
        
        let messageChild = Message.toDict(message: message)
        
        // Hijo de discusión por cada mensaje
        ref.child(message.messageId).updateChildValues(messageChild) { (error, _) in
            if let err = error, let retError = onError {
                retError(err)
            }
            
            onSuccess()
        }
    }
}
