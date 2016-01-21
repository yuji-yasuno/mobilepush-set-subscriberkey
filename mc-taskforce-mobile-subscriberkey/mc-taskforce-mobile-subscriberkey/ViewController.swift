//
//  ViewController.swift
//  mc-taskforce-mobile-subscriberkey
//
//  Created by 楊野勇智 on 2016/01/16.
//  Copyright © 2016年 salesforce.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btnLogout: UIButton!
    
    /* These are a salesforce connected application's setting */
    let consumerKey = "put your connected app consumer key"
    let redirectURI = "put yor conneted app callback url"
    let host = "this is login domain(optional)"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSalesforceSDKManager()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Custom Methods
    func setupSalesforceSDKManager() {
        SFUserAccountManager.sharedInstance().loginHost = host
        SalesforceSDKManager.sharedManager().connectedAppId = consumerKey
        SalesforceSDKManager.sharedManager().connectedAppCallbackUri = redirectURI
        SalesforceSDKManager.sharedManager().authScopes = ["web", "api"]
        //SalesforceSDKManager.sharedManager().authenticateAtLaunch = false
        SalesforceSDKManager.sharedManager().postLaunchAction = { (launchActionList : SFSDKLaunchAction) in
            print("postLaunchAction()")
            self.checkLoginStatus()
            ETPush.pushManager().setSubscriberKey(SFUserAccountManager.sharedInstance().currentUser.userName)
            ETPush.pushManager().updateET()
        }
        SalesforceSDKManager.sharedManager().launchErrorAction = { ( error : NSError!, launchActionList : SFSDKLaunchAction ) in
            print("launchErrorAction()")
            self.checkLoginStatus()
        }
        SalesforceSDKManager.sharedManager().postLogoutAction = {
            print("postLogoutAction()")
            self.checkLoginStatus()
        }
    }
    
    func checkLoginStatus() {
        if SFUserAccountManager.sharedInstance().currentUser != nil {
            btnLogout.enabled = true
            let currentUser = SFUserAccountManager.sharedInstance().currentUser
            print("username: \(currentUser.userName)")
        } else {
            btnLogout.enabled = false
            print("no user")
        }
    }
    
    // MARK: - Events
    
    @IBAction func login(sender: AnyObject) {
        SalesforceSDKManager.sharedManager().launch()
    }
    
    @IBAction func logout(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "account_logout_pref")
        SalesforceSDKManager.sharedManager().launch()
    }
    
}

