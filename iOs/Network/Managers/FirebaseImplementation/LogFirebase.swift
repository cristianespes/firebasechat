//
//  LogFirebase.swift
//  ChatKeepcoding
//
//  Created by CRISTIAN ESPES on 10/12/2018.
//  Copyright © 2018 ERISCO. All rights reserved.
//

import Foundation
import Firebase

class LogFirebase: LogManager {
    func log(event: Event) {
        Analytics.setScreenName(event.screen, screenClass: event.type)
        Analytics.logEvent(event.name, parameters: event.parameters as? [String : Any])
    }
}
