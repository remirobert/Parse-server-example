//
//  AppDelegate.swift
//  App
//
//  Created by Remi Robert on 06/04/16.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func setupApperance() {
        let nabBarApparence = UINavigationBar.appearance()
        nabBarApparence.barStyle = .Black
        nabBarApparence.tintColor = UIColor.whiteColor()
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let configuration = ParseClientConfiguration {
            $0.applicationId = "63966E18-33C1-431B-A50E-4F68652C2A4D"
            $0.clientKey = "5B45972F-36B7-4FBB-85A0-B2EA733586CD"
            $0.server = "http://127.0.0.1:8001/parse"
        }
        Parse.initializeWithConfiguration(configuration)

        self.setupApperance()
        return true
    }
}