//
//  AppDelegate+Notification.swift
//  ChatKeepcoding
//
//  Created by CRISTIAN ESPES on 11/12/2018.
//  Copyright © 2018 ERISCO. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
import FirebaseMessaging

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func registerForPushNotificacions(_ application: UIApplication) {
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { _, _ in})
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().subscribe(toTopic: "ALL")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Sumar 1 al icono de la app cuando recibamos la notificacion en segundo plano
        processNotificacion(notification)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Sumar 1 al icono de la app cuando recibamos la notificacion en primer plano
        processNotificacion(response.notification)
    }
    
    private func processNotificacion(_ notification: UNNotification) {
        // TODO: Hacer algo con esto
    }
    
}
