//
//  ViewController.swift
//  Notification
//
//  Created by erkut on 29.01.2024.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    var permissionCheck = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            self.permissionCheck = granted
            
            if granted {
                print("Permission operation success")
            } else {
                print("Permission operation failed")
            }
        }
    }

    @IBAction func makeNotificationButton(_ sender: Any) {
        if permissionCheck {
            let content = UNMutableNotificationContent()
            content.title = "Title"
            content.subtitle = "Subtitle"
            content.body = "Message"
            content.badge = 1
            content.sound = UNNotificationSound.default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
            
            let notificationRequest = UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(notificationRequest)
        }
    }
}

extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let app = UIApplication.shared
        app.applicationIconBadgeNumber = 0
        print("Notification selected")
        
        if app.applicationState == .active {
            print("In App: Notification Selected")
        }
        
        if app.applicationState == .inactive {
            print("Out App: Notification Selected")
        }
        
        completionHandler()
    }
}

