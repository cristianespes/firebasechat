//
//  Message+Firebase.swift
//  ChatKeepcoding
//
//  Created by CRISTIAN ESPES on 10/12/2018.
//  Copyright © 2018 ERISCO. All rights reserved.
//

import Foundation
import Firebase
import MessageKit
import FirebaseDatabase

extension Message {
    class func mapper(snapshot: DataSnapshot) -> Message? {
        
        guard let json = snapshot.value as? [String : Any ] else { return nil}
        
        let senderId = ( json["senderId"] as? String ) ?? ""
        let displayName = ( json["displayName"] as? String ) ?? ""
        
        let messageId = ( json["messageId"] as? String ) ?? ""
        let dateString = json["sentDate"] as? String ?? ""
        let sentDate = Date.fromStringToDate(input: dateString, format: "yyyy-MM-dd HH:mm:ss")
        
        let type = json["type"] as? String ?? ""
        let value = json["value"] as? String ?? ""
        var messageData: MessageData
        
        switch type {
        case MessageTypeEnum.text.rawValue:
            messageData = MessageData.text(value)
        case MessageTypeEnum.image.rawValue:
            let placeholder = UIImage.init(named: "placeholder")
            messageData = MessageData.photo(placeholder!)
        default:
            messageData = MessageData.text(value)
        }
        
        let sender = Sender.init(id: senderId, displayName: displayName)
        let message = Message.init(sender: sender, messageId: messageId, sentDate: sentDate, data: messageData, type: type, value: value)
        
        return message
    }
    
    class func toDict(message: Message) -> [String : String] {
        var dict = [String : String]()
        
        let date = Date.fromDateToString(date: Date(), format: "yyyy-MM-dd HH:mm:ss")
        
        dict["messageId"] = message.messageId
        dict["senderId"] = message.sender.id
        dict["displayName"] = message.sender.displayName
        dict["sentDate"] = date
        dict["type"] = message.type
        dict["value"] = message.value
        
        return dict
    }
}
