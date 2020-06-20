//
//  ViewController.swift
//  FlutteriOS
//
//  Created by Rodrigo Morbach on 20/06/20.
//  Copyright © 2020 Morbach Inc. All rights reserved.
//

import UIKit
import Flutter

protocol LoginViewControllerDelegate: AnyObject {
    func navigateToHomeScreen(withUsername username: String, password: String)
}

final class LoginViewController: UIViewController {
    
    private weak var delegate: LoginViewControllerDelegate?
    
    override func loadView() {
        view = LoginView(withDelegate: self)
        view.backgroundColor = UIColor(red: 23/255, green: 150/255, blue: 243/255, alpha: 1.0)
    }
    
    init(withDelegate delegate: LoginViewControllerDelegate?) {
        self.delegate = delegate
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
        delegate?.navigateToHomeScreen(withUsername: user, password: password)
    }
}
