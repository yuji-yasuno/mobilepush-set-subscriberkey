//
//  AppDelegate.swift
//  mc-taskforce-mobile-subscriberkey
//
//  Created by 楊野勇智 on 2016/01/16.
//  Copyright © 2016年 salesforce.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let etAppId = "Put you're marketing cloud application id"
    let etAccessToken = "Put you're marketing cloud application access token"
    
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        ETPush.setETLoggerToRequiredState(true)
        var success = false
        do {
            try ETPush.pushManager().configureSDKWithAppID(etAppId, andAccessToken: etAccessToken, withAnalytics: true, andLocationServices: true, andCloudPages: true, withPIAnalytics: true)
            success = true
        } catch let error as NSError {
            print("error: \(error.description)")
        }
        
        if success {
            let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
            ETPush.pushManager().registerUserNotificationSettings(settings)
            ETPush.pushManager().registerForRemoteNotifications()
            ETPush.pushManager().applicationLaunchedWithOptions(launchOptions)
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - Delegates for Push Notification
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        ETPush.pushManager().didRegisterUserNotificationSettings(notificationSettings)
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        ETPush.pushManager().registerDeviceToken(deviceToken)
        ETPush.pushManager().setSubscriberKey("unknown_user")
        ETPush.pushManager().updateET()
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        ETPush.pushManager().applicationDidFailToRegisterForRemoteNotificationsWithError(error)
    }
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        ETPush.pushManager().handleNotification(userInfo, forApplicationState: application.applicationState)
    }
}

