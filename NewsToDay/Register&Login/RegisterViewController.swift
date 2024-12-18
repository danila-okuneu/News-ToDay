//
//  RegisterViewController.swift
//  NewsToDay
//
//  Created by Anna Melekhina on 29.10.2024.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class RegisterViewController: TitlesBaseViewController {
	
	let usernameField = UITextField()
	let emailField = UITextField()
	let passwordField = UITextField()
	let confirmField = UITextField()
	
	let signUpButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("sign_up".localized(), for: .normal)
		button.backgroundColor = UIColor.app(.purplePrimary)
		button.setTitleColor(.white, for: .normal)
		button.layer.cornerRadius = 15
		button.titleLabel?.font = UIFont.interFont(ofSize: 18, weight: .semibold)
		button.heightAnchor.constraint(equalToConstant: 56).isActive = true
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	let loginButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("already_have_account".localized(), for: .normal)
		button.setTitleColor(UIColor.app(.blackLighter), for: .normal)
		button.titleLabel?.font = UIFont.interFont(ofSize: 16)
		button.heightAnchor.constraint(equalToConstant: 56).isActive = true
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	// MARK: - Life cycle
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
	
	override func viewWillAppear(_ animated: Bool) {
		addObserverForLocalization()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		removeObserverForLocalization()
	}
	
	// MARK: setup UI
	func setupUI() {
		setTitlesNavBar(
			title: "bar_welcome".localized(),
			description: "bar_welcome_description".localized()
		)
		
		usernameField.configureTextField(placeholder: "username_placeholder".localized(), icon: UIImage(systemName: "person"))
		emailField.configureTextField(placeholder: "email_placeholder".localized(), icon: UIImage(systemName: "envelope"))
		passwordField.configurePasswordField(placeholder: "password_placeholder".localized())
		confirmField.configurePasswordField(placeholder: "confirm_password_placeholder".localized())
		
		usernameField.autocapitalizationType = .none
		emailField.autocapitalizationType = .none
		emailField.textContentType = .emailAddress
		
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
	
	// MARK: - signUP Method & Firebase
	@objc func signUpPressed() {
		if let username = usernameField.text, !username.isEmpty,
		   let email = emailField.text, !email.isEmpty {

			if passwordField.text == confirmField.text {
				if let password = passwordField.text {
					Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
						if let e = error {
							print(e.localizedDescription)
						} else {
							print("User registered successfully")
							
							Auth.auth().currentUser?.createProfileChangeRequest().displayName = username
							Auth.auth().currentUser?.createProfileChangeRequest().commitChanges { error in
								if let error = error {
									print("Error updating profile: \(error.localizedDescription)")
								} else {
									print("User profile updated successfully")
									
									guard let userId = Auth.auth().currentUser?.uid else { return }
									let db = Firestore.firestore()
									db.collection("users").document(userId).setData([
										"uid": userId,
										"displayName": username,
										"email": email
									]) { error in
										if let error = error {
											print("Error saving user data to Firestore: \(error.localizedDescription)")
										} else {
											print("User data saved to Firestore successfully")
											
											DefaultsManager.isRegistered = true
											DispatchQueue.main.async {
												let categoriesVC = FavoriteTopicsViewController()
												categoriesVC.modalPresentationStyle = .fullScreen
												categoriesVC.modalTransitionStyle = .coverVertical
												self.present(categoriesVC, animated: true)
											}
										}
									}
								}
							}
						}
					}
				}
			} else {
				passwordAlert(title: "password_mismatch_alert".localized())
			}
		} else {
			passwordAlert(title: "enter_name_email_alert".localized())
		}
	}

	func passwordAlert(title: String) {
		let alert = UIAlertController(title: title, message: "alert_try_again".localized(), preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "alert_ok".localized(), style: .default, handler: nil))
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			self.present(alert, animated: true, completion: nil)
		}
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

// MARK: - Localization
extension RegisterViewController {
	private func addObserverForLocalization() {
		NotificationCenter.default.addObserver(
			forName: LanguageManager.languageDidChangeNotification,
			object: nil,
			queue: .main
		) { [weak self] _ in
			self?.updateLocalizedText()
		}
	}
	
	private func removeObserverForLocalization() {
		NotificationCenter.default.removeObserver(
			self,
			name: LanguageManager.languageDidChangeNotification,
			object: nil
		)
	}
	
	@objc private func updateLocalizedText() {
		setTitlesNavBar(
			title: "bar_welcome".localized(),
			description: "bar_welcome_description".localized()
		)
		signUpButton.setTitle("sign_up".localized(), for: .normal)
		loginButton.setTitle("already_have_account".localized(), for: .normal)
		
		usernameField.placeholder = "username_placeholder".localized()
		emailField.placeholder = "email_placeholder".localized()
		passwordField.placeholder = "password_placeholder".localized()
		confirmField.placeholder = "confirm_password_placeholder".localized()
	}
}
