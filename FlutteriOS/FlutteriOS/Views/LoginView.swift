//
//  LoginView.swift
//  FlutteriOS
//
//  Created by Rodrigo Morbach on 20/06/20.
//  Copyright © 2020 Morbach Inc. All rights reserved.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func userDidPressLogin(username: String?, password: String?)
}

class LoginView: UIView {
        
    private weak var delegate: LoginViewDelegate?
    
    private lazy var fieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.spacing = 10.0
        stackView.alignment = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter your username"
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.placeholder = "Enter your password"
        return textField
    }()
    
    private lazy var enterButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Enter", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    init(withDelegate delegate: LoginViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    @objc func login(sender: UIButton? = nil) {
        dismissKeyboard()
        delegate?.userDidPressLogin(username: username, password: password)
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
}

extension LoginView: CodeView {
    func setupConstraints() {
        fieldsStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
               fieldsStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        fieldsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        fieldsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }
    func setupComponents() {
        fieldsStackView.addArrangedSubview(usernameTextField)
        fieldsStackView.addArrangedSubview(passwordTextField)
        fieldsStackView.addArrangedSubview(enterButton)
        self.addSubview(fieldsStackView)
    }
    
    func setupExtraConfigurations() {
        enterButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture)
    }
}

extension LoginView {
    private var username: String? {
        return usernameTextField.text
    }
    private var password: String? {
        return passwordTextField.text
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
