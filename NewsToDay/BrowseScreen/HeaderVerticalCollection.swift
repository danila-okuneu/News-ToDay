//
//  HeaderVerticalCollection.swift
//  NewsToDay
//
//  Created by Олег Дербин on 25.10.2024.
//

import UIKit
import SnapKit
class HeaderVerticalCollection: UITextField {
    
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
        title.text = "Recommended for you"
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
        viewAll.setTitle("See All", for: .normal)
        viewAll.titleLabel?.font = UIFont.interFont(ofSize: 14, weight: .regular)
        viewAll.setTitleColor(UIColor.app(.greyPrimary), for: .normal)
        
        viewAll.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.height.equalTo(25)
            make.top.equalToSuperview().inset(35)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}

