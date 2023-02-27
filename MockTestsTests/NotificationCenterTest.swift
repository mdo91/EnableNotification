//
//  NotificationCenterTest.swift
//  MockTestsTests
//
//  Created by Mahmoud Aoata on 5.02.2023.
//

import XCTest

final class NotificationCenterTest: XCTestCase {


    override class func setUp() {
        super.setUp()
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    func testSuccessfulAuthorization() {
        let center = UserNotificationCenterMock()
        let manager = PushNotificationManager(notificationCenter: center)
        
        center.grantAuthorization = true
        var status: PushNotificationManager.Status?
        
        manager.enableNotifications { status = $0 }
        
        XCTAssertEqual(status, .enabled)
    }

}
