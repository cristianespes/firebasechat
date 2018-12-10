//
//  DiscussionFirebase.swift
//  ChatKeepcoding
//
//  Created by CRISTIAN ESPES on 10/12/2018.
//  Copyright © 2018 ERISCO. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseUI

class DiscussionFirebase: DiscussionManager {
    
    var ref = Database.database().reference().child("discussions")
    
    func list(onSuccess: @escaping ([Discussion]) -> Void, onError: ErrorClosure?) {
        
        ref.observe(.value, with: { (snapshot) in
            let discussions = snapshot.children.compactMap({ Discussion.mapper(snapshot: $0 as! DataSnapshot) }).sorted(by: { $0.title < $1.title})
            
            onSuccess(discussions)
        }) { (error) in
            if let retError = onError {
                retError(error)
            }
        }
        
    }
}
