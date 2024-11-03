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
	
	let signInButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("sign_in".localized(), for: .normal)
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
		button.setTitle("register_prompt".localized(), for: .normal)
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
	
	func setupUI() {
		setTitlesNavBar(
			title: "welcome_back".localized(),
			description: "welcome_description".localized()
		)
		
		emailField.configureTextField(placeholder: "email_placeholder".localized(), icon: UIImage(systemName: "envelope"))
		passwordField.configurePasswordField(placeholder: "password_placeholder".localized())
		
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
	
	@objc func signUpPressed() {
		if let password = passwordField.text, !password.isEmpty,
		   let email = emailField.text, !email.isEmpty {
			
			Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
				if let e = error {
					print(e.localizedDescription)
					self.passwordAlert(title: "wrong_credentials_alert".localized())
				} else {
					print("go to screen")
					DefaultsManager.isRegistered = true
					DispatchQueue.main.async {
						let tabController = TabController()
						if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
						   let window = windowScene.windows.first {
							window.rootViewController = tabController
							if !DefaultsManager.hasSelectedCategories {
								tabController.present(FavoriteTopicsViewController(), animated: true)
							}
							window.makeKeyAndVisible()
						}
					}
				}
			}
		} else {
			passwordAlert(title: "missing_credentials_alert".localized())
		}
	}
	
	@objc func registerPressed() {
		let loginVC = RegisterViewController()
		loginVC.modalPresentationStyle = .overFullScreen
		self.present(loginVC, animated: true, completion: nil)
	}
	
	func passwordAlert(title: String) {
		let alert = UIAlertController(title: title, message: "try_again".localized(), preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "alert_ok".localized(), style: .default, handler: nil))
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

