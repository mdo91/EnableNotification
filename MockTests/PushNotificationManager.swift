//
//  PushNotificationManager.swift
//  MockTests
//
//  Created by Mahmoud Aoata on 5.02.2023.
//

import Foundation
import UserNotifications

protocol UserNotificationCenter {
    func requestAuthorization(options: UNAuthorizationOptions,
                              completionHandler: @escaping (Bool, Error?) -> Void)
}

extension UNUserNotificationCenter: UserNotificationCenter {}

class UserNotificationCenterMock: UserNotificationCenter {
    // properties needed to control the outcome of request Authorization
    
    var grantAuthorization: Bool = false
    var error: Error?
    
    func requestAuthorization(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void) {
        // we execute completion handler right away, synchronously
        completionHandler(grantAuthorization, error)
    }
}

class PushNotificationManager {
    
    let userNotificationCenter: UserNotificationCenter
    
    var status: Status?
    
    init(notificationCenter: UserNotificationCenter ) {
        self.userNotificationCenter = notificationCenter
    }
    
     func enableNotifications(completionHandler: @escaping (Status) -> Void) {
        
        userNotificationCenter.requestAuthorization(options: [.badge, .alert, .sound]) { [weak self] granted, error in
            guard let self = self else {return}
            if let error = error {
                print("Error \(error.localizedDescription)")
                self.status = .notEnabled
                completionHandler(.notEnabled)
            }
            
            if granted {
                self.status = .enabled
                completionHandler(.enabled)
            } else {
                self.status = .notEnabled
                completionHandler(.notEnabled)
            }
        }
    }
   
    enum Status {
        case enabled
        case notEnabled
    }
}




