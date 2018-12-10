//
//  Discussion+Firebase.swift
//  ChatKeepcoding
//
//  Created by CRISTIAN ESPES on 10/12/2018.
//  Copyright © 2018 ERISCO. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

extension Discussion {
    
    // Le pasamos un objecto de Firebase y unos devuelva un Discussion
    
    class func mapper(snapshot: DataSnapshot) -> Discussion? {
        guard let json = snapshot.value as? [String : Any] else { return nil }
        
        let uid = ( json["uid"] as? String ) ?? ""
        let title = ( json["title"] as? String ) ?? ""
        
        return Discussion.init(uid: uid, title: title)
    }
    
    
}
