//
//  ProfileViewController.swift
//  NewsToDay
//
//  Created by SM Team 6 on 20.10.24.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

final class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	private lazy var avatar: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "avatar")
		imageView.layer.cornerRadius = Constants.avatarHeight / 2
		imageView.backgroundColor = .app(.greyLight)
		return imageView
	}()
	
	private let scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.alwaysBounceVertical = true
		return scrollView
	}()
	
	private let scrollViewContainer: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.alignment = .fill
		stack.spacing = 7
		stack.distribution = .fillEqually
		return stack
	}()
	
	private let nameLabel: UILabel = {
		let label = UILabel()
		label.font = .interFont(ofSize: 20, weight: .semibold)
		label.textColor = .app(.blackDark)
		label.text = "Team 6"
		return label
	}()
	
	private let emailLabel: UILabel = {
		let label = UILabel()
		label.textColor = .app(.blackLighter)
		label.text = "team6@best.com"
		label.font = .interFont(ofSize: 18)
		return label
	}()

	
	
	private let forwardButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage(systemName: "gearshape"), for: .normal)
		button.tintColor = .app(.blackPrimary)
		button.imageView?.contentMode = .scaleAspectFit
		return button
	}()
    
    
    let imagePicker = ImagePicker()
        
    
    
	
	private var languageButton = CustomButton(withTitle: "language_profile_cell".localized(), image: "chevron.right")
	private let signOutButton = CustomButton(withTitle: "sign_out_profile_cell".localized(), image: "iphone.and.arrow.forward")
	private let termsButton = CustomButton(withTitle: "terms_conditions_profile_cell".localized(), image: "chevron.right")
	
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		
		
		
		setupViews()
		setupButtonTargets()
		setupGestureRecognizer()
		
        loadUserProfile()
		
	}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserverForLocalization()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserverForLocalization()
    }
	
	
	// MARK: - Layout
	private func setupViews() {
		
        title = "profile_screen_title".localized()

		self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.app(.blackPrimary)]
		
		self.navigationController?.navigationBar.prefersLargeTitles = true
		view.backgroundColor = .white
	
	
		view.addSubview(avatar)
		view.addSubview(nameLabel)
		view.addSubview(emailLabel)
		
		
		makeConstaints()
		setupScrollView()
		
		
	}
	
	private func makeConstaints() {
		
		avatar.snp.makeConstraints { make in
			make.width.height.equalTo(Constants.avatarHeight)
			make.left.equalToSuperview().offset(Constants.spacing)
			make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
		}
		
		
		nameLabel.snp.makeConstraints { make in
			make.left.equalTo(avatar.snp.right).offset(Constants.spacing)
			make.centerY.equalTo(avatar.snp.centerY).offset(-10)
			make.height.equalTo(20)
		}
		
		emailLabel.snp.makeConstraints { make in
			make.centerY.equalTo(avatar.snp.centerY).offset(10)
			make.left.equalTo(avatar.snp.right).offset(Constants.spacing)
			make.height.equalTo(20)
		}
		
	
//		 setupSettingsButton()
	}
	
	
	private func setupGestureRecognizer() {
		
		let gesture = UITapGestureRecognizer(target: self, action: #selector(self.pickImage))
		avatar.addGestureRecognizer(gesture)
		avatar.isUserInteractionEnabled = true
		
	}
	
	private func setupSettingsButton() {
		
		guard self.navigationController != nil else { return }
		
		
		let settingsButton: UIButton = {
			let button = UIButton()
			button.setImage(UIImage(systemName: "gearshape"), for: .normal)
			button.tintColor = .app(.blackPrimary)
			button.imageView?.contentMode = .scaleAspectFit
			return button
		}()
		
		
		self.navigationController?.navigationBar.addSubview(settingsButton)
		
	
		settingsButton.imageView?.snp.makeConstraints({ make in
			make.height.width.equalTo(35)
		})
		
		settingsButton.snp.makeConstraints { make in
			make.height.width.equalTo(35)
			
			make.right.equalToSuperview().offset(-Constants.spacing)
			make.bottom.equalToSuperview().offset(-12)
		}
	}
	
	
	private func setupScrollView() {
		view.addSubview(scrollView)
		
		scrollView.snp.makeConstraints { make in
			make.top.equalTo(avatar.snp.bottom).offset(20)
			make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(Constants.spacing)
			make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-Constants.spacing)
			make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
		}
		
		scrollView.addSubview(scrollViewContainer)
		
		scrollViewContainer.snp.makeConstraints { make in
			make.width.equalToSuperview()
			make.top.equalToSuperview()
			make.bottom.equalToSuperview()
		}
		
		let spacerView = UIView()
			scrollViewContainer.addArrangedSubview(spacerView)
			
			// Параметры для spacerView, чтобы он занимал всё доступное пространство
			spacerView.snp.makeConstraints { make in
				make.height.greaterThanOrEqualTo(1)
			}
			
			scrollViewContainer.addArrangedSubview(languageButton)
			scrollViewContainer.addArrangedSubview(termsButton)
			scrollViewContainer.addArrangedSubview(signOutButton)
			
			languageButton.snp.makeConstraints { make in
				make.height.equalTo(Constants.buttonHeight)
			}
		
		languageButton.snp.makeConstraints { make in
			make.height.equalTo(Constants.buttonHeight)
		}
	
	}
	
	private func setupButtonTargets() {
		
		languageButton.addTarget(self, action: #selector(languageButtonTapped), for: .touchUpInside)
		termsButton.addTarget(self, action: #selector(TermsButtonTapped), for: .touchUpInside)
		signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)

	}
	

	
	// MARK: - @objc methods
	
	@objc private func pickImage() {
		
//		print("Tapped")
        imagePicker.showImagePicker(in: self) { image in
            self.avatar.image = image
        }
        
		
	}
	
	
	
	@objc private func languageButtonTapped() {
		self.navigationController?.pushViewController(LanguageViewController(), animated: true)
	}
	
	@objc private func signOutButtonTapped() {

        do {
          try Auth.auth().signOut()
            
			let loginVC = LoginViewController()
			loginVC.modalPresentationStyle = .fullScreen
			loginVC.modalTransitionStyle = .flipHorizontal
            self.present(loginVC, animated: true, completion: nil)
            
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        } 
        
        
        
	}
	
	@objc private func TermsButtonTapped() {
		self.navigationController?.pushViewController(TermsViewController(), animated: true)
	}
    
    //MARK: Firebase
    func loadUserProfile() {
    
        emailLabel.text = Auth.auth().currentUser?.email

        let db = Firestore.firestore()
        let userID = Auth.auth().currentUser?.uid ?? "no user"
           
           db.collection("users").document(userID).getDocument { (document, error) in
               if let error = error {
                   print("Error getting document: \(error)")
                   return
               }

               if let document = document, document.exists {
                   let data = document.data()
                   let username = data?["displayName"] as? String ?? "No Name"
                   self.nameLabel.text = username
               } else {
                   print("Document does not exist")
               }
           }
       }
    
    //MARK: - Localization
    private func addObserverForLocalization() {
        NotificationCenter.default.addObserver(forName: LanguageManager.languageDidChangeNotification, object: nil, queue: .main) { [weak self] _ in
            self?.updateLocalizedText()
        }
    }
    
    private func removeObserverForLocalization() {
        NotificationCenter.default.removeObserver(self, name: LanguageManager.languageDidChangeNotification, object: nil)
    }
    
    @objc func updateLocalizedText() {
        title = "profile_screen_title".localized()
        languageButton.updateTitle("language_profile_cell".localized())
        termsButton.updateTitle("terms_conditions_profile_cell".localized())
        signOutButton.updateTitle("sign_out_profile_cell".localized())
    }
}




extension ProfileViewController {
	
	private struct Constants {
		
		static let screenHeight = UIScreen.main.bounds.height
		static let screenWidth = UIScreen.main.bounds.width
		
		
		static let avatarWidth = screenWidth * (72/375)
		static let avatarHeight = avatarWidth
		
		static let buttonHeight = screenHeight * (56/812)
		static let spacing = screenWidth * (20/375)
		
		
	}
}

