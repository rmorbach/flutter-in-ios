//
//  FlutterChannelHandler.swift
//  FlutteriOS
//
//  Created by Rodrigo Morbach on 20/06/20.
//  Copyright © 2020 Morbach Inc. All rights reserved.
//

import Foundation
import Flutter

final class FlutterViewControllerHolder {
    
    static let shared = FlutterViewControllerHolder()
    
    var flutterViewController: FlutterViewController? {
        return viewController
    }
    
    private var viewController: FlutterViewController?
    
    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        guard let engine = appDelegate.flutterEngine else {
            return
        }
        engine.run(withEntrypoint: "main")
        // Show flutter screen
        self.viewController = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
    }

    
}
