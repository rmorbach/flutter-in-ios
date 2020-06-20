//
//  ViewController.swift
//  FlutteriOS
//
//  Created by Rodrigo Morbach on 20/06/20.
//  Copyright © 2020 Morbach Inc. All rights reserved.
//

import UIKit
import Flutter
final class LoginViewController: UIViewController {
    
    override func loadView() {
        view = LoginView(withDelegate: self)
        view.backgroundColor = UIColor(red: 23/255, green: 150/255, blue: 243/255, alpha: 1.0)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func showAlert(title: String = "Warning", text: String) {
        let alertController = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

extension LoginViewController: LoginViewDelegate {
    func userDidPressLogin(username: String?, password: String?) {
        guard let user = username, user.isEmpty == false else {
            showAlert(text: "Please provide your user name")
            return
        }
        guard let password = password, password.isEmpty == false else {
            showAlert(text: "Please provide your password")
            return
        }
        navigateToFlutterScreen()
    }
}

extension LoginViewController {
    func navigateToFlutterScreen() {
        // Show flutter screen
        guard let flutterViewController = FlutterViewControllerHolder.shared.flutterViewController else {
            print("Unable to create flutterViewController")
            return
        }
        flutterViewController.title = "Flutter Home Screen"
        
        addLogoutChannel(forBinaryMessenger: flutterViewController.binaryMessenger)
        
        self.navigationController?.pushAndUpdateNavigationStack(withViewController: flutterViewController)
    }
    
    func pushAndUpdateNavigationStack(withViewController viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
        self.navigationController?.viewControllers = [viewController]
    }
    
    func addLogoutChannel(forBinaryMessenger binaryMessenger: FlutterBinaryMessenger) {
        
        // Configure in order to receive messages from flutter module
        let logoutChannel = FlutterMethodChannel(name: "flutter.ios.functions/logout", binaryMessenger: binaryMessenger)
        logoutChannel.setMethodCallHandler { (call, result) in
            let firstWindow = UIApplication.shared.windows.first
            guard let naviController = firstWindow?.rootViewController as? UINavigationController else {
                return
            }
            switch call.method {
            case "logout":
                let loginViewController = LoginViewController()
                naviController.pushAndUpdateNavigationStack(withViewController: loginViewController)
                result(nil)
            default: break
            }
        }
    }
}

extension UINavigationController {
    func pushAndUpdateNavigationStack(withViewController viewController: UIViewController) {
            pushViewController(viewController, animated: true)
           viewControllers = [viewController]
       }
}
