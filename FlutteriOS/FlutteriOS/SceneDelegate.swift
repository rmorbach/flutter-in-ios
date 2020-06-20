//
//  SceneDelegate.swift
//  FlutteriOS
//
//  Created by Rodrigo Morbach on 20/06/20.
//  Copyright © 2020 Morbach Inc. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let appWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
        appWindow.windowScene = windowScene
        let navController = UINavigationController()
        let coordinator = MainCoordinator(withNavigationController: navController)
        appDelegate.coordinator = coordinator
        coordinator.start()
        appWindow.makeKeyAndVisible()
        appWindow.rootViewController = navController
        self.window = appWindow
    }
}

