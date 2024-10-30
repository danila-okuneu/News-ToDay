//
//  RegisterViewController.swift
//  NewsToDay
//
//  Created by Anna Melekhina on 29.10.2024.
//

import UIKit

class RegisterViewController: TitlesBaseViewController {
    
    let usernameField = UITextField()
    let emailField = UITextField()
    let passwordField = UITextField()
    let confirmField = UITextField()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor.app(.purplePrimary)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.interFont(ofSize: 16)
        button.heightAnchor.constraint(equalToConstant: 56).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Already have an account? Sign in", for: .normal)
        button.setTitleColor(UIColor.app(.blackLighter), for: .normal)
        button.titleLabel?.font = UIFont.interFont(ofSize: 16)
        button.heightAnchor.constraint(equalToConstant: 56).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupUI()
        signUpButton.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)

        
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        confirmField.delegate = self
        
    }
    
    
    
    
    
    
    // MARK: setup UI
    
    func setupUI() {
        
        setTitlesNavBar(title: "Welcome to News ToDay", description: "Hello, I guess you are new around here. You can start using the application after sign up")
        
        usernameField.configureTextField(placeholder: "Username", icon: UIImage(systemName: "person"))
        emailField.configureTextField(placeholder: "Email Address", icon: UIImage(systemName: "envelope"))
        passwordField.configurePasswordField(placeholder: "Password")
        confirmField.configurePasswordField(placeholder: "Repeat Password")
        
        
        let stackView = UIStackView(arrangedSubviews: [usernameField, emailField, passwordField, confirmField, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(loginButton)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
      
    }
    
    @objc func signUpPressed() {
        print("hello")
    }
    
    @objc func loginPressed() {
      
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .overFullScreen
        self.present(loginVC, animated: true, completion: nil)
    }
    
    
    
}

// MARK: - UITextFieldDelegate

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.app(.purplePrimary).cgColor
            textField.backgroundColor = .white
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            textField.layer.borderColor = UIColor.app(.greyLighter).cgColor
            textField.backgroundColor = UIColor.app(.greyLighter)
        }
    }
    
}
#Preview { RegisterViewController() }
