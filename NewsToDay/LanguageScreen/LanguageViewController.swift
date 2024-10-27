//
//  LanguageViewController.swift
//  NewsToDay
//
//  Created by Danila Okuneu on 22.10.24.
//

import UIKit
import SnapKit


final class LanguageViewController: UIViewController {
	
	private var selectedIndexPath: IndexPath?
	static let cellIdentifire = "LanguageCell"
	
	// MARK: - UI Components
	private let tableView: UITableView = {
		let tableView = UITableView()
		tableView.rowHeight = Constants.buttonHeight + 10
		tableView.separatorStyle = .none
		tableView.register(LanguageTableViewCell.self, forCellReuseIdentifier: LanguageTableViewCell.reusableIdentifire)
		tableView.separatorColor = nil
		return tableView
	}()
	
	
	
	override func viewDidLoad() {
			
		let label: UILabel = UILabel()
		label.minimumScaleFactor = 0.1
		label.adjustsFontSizeToFitWidth = true
		
		setupViews()

		tableView.delegate = self
		tableView.dataSource = self
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		view.backgroundColor = .white
	}
	
	
	
	private func setupViews() {
		
		title = "language".localized()
		
		makeConstraints()
	}

	private func makeConstraints() {
		
		
		view.addSubview(tableView)
		tableView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
			make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
			make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(15)
			make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-12)
			
		}
	}
	
		
	
	
}


extension LanguageViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return Language.allCases.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	
		let cell = tableView.dequeueReusableCell(withIdentifier: LanguageTableViewCell.reusableIdentifire, for: indexPath) as! LanguageTableViewCell
		
		let language = Language.allCases[indexPath.row]
				
        let isSelected = language.rawValue == LanguageManager.shared.currentLanguage
				
			cell.configure(with: language, isSelected: isSelected)
		if isSelected {
			selectedIndexPath = indexPath
		}
			return cell
	}
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		guard let selectedIndexPath else { return }
		guard selectedIndexPath != indexPath else { return }
		
		let previousCell = tableView.cellForRow(at: selectedIndexPath) as! LanguageTableViewCell
		previousCell.updateButtonSelection(for: false)
		
		let selectedCell = tableView.cellForRow(at: indexPath) as! LanguageTableViewCell
		selectedCell.updateButtonSelection(for: true)
		
        LanguageManager.shared.setLanguage(selectedCell.language?.rawValue ?? "en")
		
		title = "language".localized()
		
		self.selectedIndexPath = indexPath
	}
}



private struct Constants {
	
	static let screenHeight = UIScreen.main.bounds.height
	static let screenWidth = UIScreen.main.bounds.width
	
	
	static let avatarWidth = screenWidth * (72/375)
	static let avatarHeight = avatarWidth
	
	static let buttonHeight = screenHeight * (56/812)
	static let spacing = screenWidth * (20/375)
	
	
}
