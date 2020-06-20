//
//  AppDelegate.swift
//  FlutteriOS
//
//  Created by Rodrigo Morbach on 20/06/20.
//  Copyright © 2020 Morbach Inc. All rights reserved.
//

import UIKit
import Flutter
import FlutterPluginRegistrant
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var flutterEngine = FlutterEngine(name: "Test engine", project: nil)
    var coordinator: MainCoordinator?
            
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.        
        return true
    }

}

