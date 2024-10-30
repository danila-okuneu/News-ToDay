//
//  LoginViewController.swift
//  NewsToDay
//
//  Created by Anna Melekhina on 29.10.2024.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class LoginViewController: TitlesBaseViewController {

    let usernameField = UITextField()
    let emailField = UITextField()
    let passwordField = UITextField()
    
    let signInButton: UIButton = {  // cиняя кнопка
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = UIColor.app(.purplePrimary)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.interFont(ofSize: 16)
        button.heightAnchor.constraint(equalToConstant: 56).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don't have an account? Sign up", for: .normal)
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
        signInButton.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)

        
        emailField.delegate = self
        passwordField.delegate = self
        
    }
    
    
    
    
    
    
    // MARK: setup UI
    
    func setupUI() {
        
        setTitlesNavBar(title: "Welcome back 👋", description: "You can continue where you left off by logging in")
        
        emailField.configureTextField(placeholder: "Email Address", icon: UIImage(systemName: "envelope"))
        passwordField.configurePasswordField(placeholder: "Password")
        
        
        let stackView = UIStackView(arrangedSubviews: [emailField, passwordField, signInButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(registerButton)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
      
    }
    
    //MARK: Login via Firebase
    
    @objc func signUpPressed() {
        print("sign in pressed")
        
        if let password = passwordField.text, !password.isEmpty,
           let email = emailField.text, !email.isEmpty {
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                    self.passwordAlert(title: "Wrong email or password")
                } else {
                    print("go to screen")
                    DispatchQueue.main.async {
                        let tabController = TabController()
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                           let window = windowScene.windows.first {
                            window.rootViewController = tabController
                            window.makeKeyAndVisible()
                        }
                    }
                }
            }
        } else {
            print("enter email or pass")
            passwordAlert(title: "Please, enter email and password")
        }
        
    }
    
    @objc func registerPressed() {
          let loginVC = RegisterViewController()
          loginVC.modalPresentationStyle = .overFullScreen
          self.present(loginVC, animated: true, completion: nil)
    }
    
    func passwordAlert(title: String) {
        let alert = UIAlertController(title: title, message: "Try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.present(alert, animated: true, completion: nil)
            }
    }
    
    
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
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
#Preview { LoginViewController() }

