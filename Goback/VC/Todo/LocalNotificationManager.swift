//
//  LocalNotificationManager.swift
//  Timemark
//
//  Created by Julian Wright on 8/12/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import Foundation
import UserNotifications

struct LocalNotification {
    var id: String
    var title: String
    var delay: Int
}

class LocalNotificationManager {
    var notifications = [LocalNotification]()
    
    
    var todo: Todo?
    
    func requestPermission() -> Void {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge, .alert, .sound]) { granted, error in
                if granted == true && error == nil {
                    // We have permission!
                }
        }
    }
    
    func addNotification(title: String) -> Void {
        notifications.append(LocalNotification(id: UUID().uuidString, title: title, delay: 0))
    }
    
    func addNotification(title: String, delay: Int) -> Void {
        notifications.append(LocalNotification(id: UUID().uuidString, title: title, delay: delay))
    }
    
    func clearNotifications() -> Void {
        notifications = [LocalNotification]()
    }
    
    func scheduleNotifications() -> Void {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = NSString.localizedUserNotificationString(forKey:
                        "item done", arguments: nil)
            content.body = NSString.localizedUserNotificationString(forKey: "your item has finished", arguments: nil)
            content.categoryIdentifier = "Your notification category"
            content.sound = UNNotificationSound.default
            content.badge = 1
            
            let dateComponents = Calendar.current.dateComponents(Set(arrayLiteral: Calendar.Component.year, Calendar.Component.month, Calendar.Component.day), from: todo!.alertDate!)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let request = UNNotificationRequest(identifier: "Your notification identifier", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                guard error == nil else { return }
                print("Scheduling notification with id: \(notification.id)")
                }
            )
        }
        clearNotifications()
    }
    
    func schedule() -> Void {
        print(notifications)
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestPermission()
            case .authorized, .provisional:
                self.scheduleNotifications()
            default:
                break
            }
        }
    }
}
