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
		textView.text = "Terms of Use Last updated: [Date] Welcome to News ToDay. By accessing or using our mobile application (the “App”), you agree to be bound by these Terms of Use (“Terms”). If you do not agree to these Terms, you should not use the App. Please read these Terms carefully before using our services. 1. Acceptance of Terms By downloading, accessing, or using the App, you agree to comply with and be bound by these Terms. If you do not agree to these Terms, please do not use the App. 2. Changes to Terms We reserve the right to modify these Terms at any time. If we make changes, we will notify you by revising the date at the top of the Terms. Your continued use of the App following any changes means you accept the revised Terms. 3. User Conduct By using the App, you agree not to: Use the App for any illegal or unauthorized purpose. Interfere with the proper working of the App, including through the use of viruses, bots, or other harmful means. Post or transmit any content that is harmful, obscene, defamatory, or otherwise objectionable. 4. User-Generated Content You may be able to submit, post, or share content within the App. You retain ownership of any content you submit, but by submitting content, you grant us a worldwide, non-exclusive, royalty-free license to use, display, and distribute such content in connection with the App. 5. Privacy Policy Your privacy is important to us. Please review our Privacy Policy, which explains how we collect, use, and share your personal information. 6. Third-Party Links The App may contain links to third-party websites or services that we do not own or control. We are not responsible for the content, privacy policies, or practices of any third-party websites or services. 7. Intellectual Property All content provided in the App, including text, graphics, logos, and software, is the property of News ToDay or its licensors. You may not copy, distribute, or modify any part of the App without our written permission. 8. Disclaimer of Warranties The App is provided on an “as is” and “as available” basis without any warranties of any kind. We do not guarantee that the App will be available, secure, or error-free at all times. 9. Limitation of Liability To the maximum extent permitted by law, News ToDay will not be liable for any direct, indirect, incidental, or consequential damages arising from your use of the App. 10. Termination We reserve the right to terminate or suspend your access to the App at any time, without notice, for conduct that we believe violates these Terms or is harmful to other users or the App. 11. Governing Law These Terms are governed by the laws of [Your Country/State]. Any legal action or proceeding arising out of these Terms will be brought in the appropriate courts located in [Your Jurisdiction]. 12. Contact Information If you have any questions about these Terms, please contact us at: [Email Address]."
		textView.textColor = UIColor.app(.greyLight)
		textView.font = .interFont(ofSize: 16)
		return textView
	}()
	
	
	
	override func viewDidLoad() {
		
		
		setupViews()
		
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
			make.edges.equalTo(view.safeAreaLayoutGuide)
		}
	}
	
	private func setupScrollView() {
		
		
		
	}
	
	
	private func setupNavigationBar() {
		
		title = "Terms & Conditions"
		self.navigationController?.navigationBar.tintColor = UIColor.app(.greyDark)
		self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.app(.blackPrimary)]
		
		self.navigationController?.navigationBar.prefersLargeTitles = true
		view.backgroundColor = .white

		
		
	}
}







