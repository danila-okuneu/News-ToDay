//
//  TermsViewController.swift
//  NewsToDay
//
//  Created by Danila Okuneu on 22.10.24.
//

import UIKit
import SnapKit

final class TermsViewController: UIViewController {
	
	// MARK: - UI Components
	
	private let textView: UITextView = {
		let textView = UITextView()
        textView.text = "textview_terms_text".localized()
		textView.textColor = UIColor.app(.greyLight)
		textView.font = .interFont(ofSize: 16)
		return textView
	}()
	
	
	
	override func viewDidLoad() {
		
		
		setupViews()
		
	}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserverForLocalization()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserverForLocalization()
    }
	
	// MARK: - Setup views
	
	private func setupViews() {
		
		
		setupNavigationBar()
		makeConstraints()
		setupScrollView()
	}
	
	private func makeConstraints() {
		
		view.addSubview(textView)
		
		textView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)

		}
	}
	
	private func setupScrollView() {
		
		
		
	}
	
	
	private func setupNavigationBar() {
		
        title = "terms_screen_title".localized()
		self.navigationController?.navigationBar.tintColor = UIColor.app(.greyDark)
		self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.app(.blackPrimary)]
		
		self.navigationController?.navigationBar.prefersLargeTitles = true
		view.backgroundColor = .white

		
		
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
    
    @objc private func updateLocalizedText() {
        title = "terms_screen_title".localized()
        textView.text = "textview_terms_text".localized()
    }
}


#Preview{ TermsViewController()} 




