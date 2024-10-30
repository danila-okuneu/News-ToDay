//
//  HeaderVerticalCollection.swift
//  NewsToDay
//
//  Created by Олег Дербин on 25.10.2024.
//

import UIKit
import SnapKit
class HeaderVerticalCollection: UIView {
    
    private let title = UILabel()
    let viewAll = UIButton()
    
    init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    private func setupLayout() {
        congigureView()
        configureTitle()
        configureButton()
    }
    
    private func congigureView() {
        self.backgroundColor = .clear
    }
    
    private func configureTitle() {
        addSubview(title)
        title.text = "recommended_section_title".localized()
        title.font = UIFont.interFont(ofSize: 20, weight: .semibold)
        title.textColor = .black
        
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.height.equalTo(25)
            make.top.equalToSuperview().inset(35)
        }
    }
    
    private func configureButton() {
        addSubview(viewAll)
        viewAll.setTitle("see_all_section_button".localized(), for: .normal)
        viewAll.titleLabel?.font = UIFont.interFont(ofSize: 14, weight: .regular)
        viewAll.setTitleColor(UIColor.app(.greyPrimary), for: .normal)
        viewAll.addTarget(self, action: #selector(seeAllTapped), for: .touchUpInside)
        
        viewAll.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.height.equalTo(25)
            make.top.equalToSuperview().inset(35)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateLocalizedText() {
        title.text = "recommended_section_title".localized()
        viewAll.setTitle("see_all_section_button".localized(), for: .normal)
    }
    
    @objc func seeAllTapped() {
        print("hello")
    }
   
}

