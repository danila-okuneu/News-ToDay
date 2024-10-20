//
//  ViewController.swift
//  News ToDay
//
//  Created by Danila Okuneu on 20.10.24.
//

import UIKit
import SnapKit

final class BrowseViewController: UIViewController {

	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.interFont(ofSize: 40, weight: .semibold)
		label.text = "Hello World!"

		return label
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .app(.purplePrimary)
		makeConstraints()
	}

	
	private func makeConstraints() {
		
		view.addSubview(titleLabel)
		
		titleLabel.snp.makeConstraints { make in
			make.center.equalToSuperview()
			make.height.equalTo(100)
			make.width.equalTo(250)
		}
		
	}

}

