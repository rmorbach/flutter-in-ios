//
//  Coordinator.swift
//  FlutteriOS
//
//  Created by Rodrigo Morbach on 20/06/20.
//  Copyright © 2020 Morbach Inc. All rights reserved.
//

import UIKit
import Flutter

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    func start()
    func finish()
}

extension Coordinator {
    func finish() { }
}

final class MainCoordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    private var username: String?
    
    init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension MainCoordinator: Coordinator {
    func start() {
        username = ""
        let loginViewController = LoginViewController(withDelegate: self)
        navigationController.pushAndUpdateNavigationStack(withViewController: loginViewController)
    }
}

extension MainCoordinator: LoginViewControllerDelegate {
    
    func navigateToHomeScreen(withUsername username: String, password: String) {
        self.username = username
        navigateToFlutterScreen()
    }
}

extension MainCoordinator {
    func navigateToFlutterScreen() {
        // Show flutter screen
        guard let flutterViewController = FlutterViewControllerHolder.shared.flutterViewController else {
            print("Unable to create flutterViewController")
            return
        }
        flutterViewController.title = "Flutter Home Screen"
        
        addLogoutChannel(forBinaryMessenger: flutterViewController.binaryMessenger)
        
        self.navigationController.pushAndUpdateNavigationStack(withViewController: flutterViewController)
    }
    
    func pushAndUpdateNavigationStack(withViewController viewController: UIViewController) {
        self.navigationController.pushViewController(viewController, animated: true)
        self.navigationController.viewControllers = [viewController]
    }
    
    
    func addLogoutChannel(forBinaryMessenger binaryMessenger: FlutterBinaryMessenger) {
        // Configure in order to receive messages from flutter module
        let loginChannel = FlutterMethodChannel(name: "flutter.ios.functions/login", binaryMessenger: binaryMessenger)
        loginChannel.invokeMethod("setUsername", arguments: self.username)
        loginChannel.setMethodCallHandler { (call, result) in
            switch call.method {
            case "logout":
                self.start()
                loginChannel.invokeMethod("setUsername", arguments: self.username)
                result(nil)
            case "getUsername":
                result(self.username)
            default: break
            }
        }
    }
}

private extension UINavigationController {
    func pushAndUpdateNavigationStack(withViewController viewController: UIViewController) {
        pushViewController(viewController, animated: true)
        viewControllers = [viewController]
    }
}

