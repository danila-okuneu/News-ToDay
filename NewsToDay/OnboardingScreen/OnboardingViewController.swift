//
//  OnboardingViewController.swift
//  NewsToDay
//
//  Created by SM Team 6 on 20.10.24.
//

import UIKit
import SnapKit


final class OnboardingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    var imageNames = ["chinatown", "handLuggage", "timesquare"]
    
    //MARK: - UI Elements
    
    
    private lazy var onboardingCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 24
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.reuseId)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = imageNames.count
        control.currentPage = 0
        control.pageIndicatorTintColor = UIColor.app(.greyLighter)
        control.currentPageIndicatorTintColor = UIColor.app(.purplePrimary)
        return control
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "first_to_know_label".localized()
        label.font = UIFont.interFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor.app(.blackPrimary)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "description_label".localized()
        label.font = UIFont.interFont(ofSize: 16)
        label.textColor = UIColor.app(.greyPrimary)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("next_button".localized(), for: .normal)
        button.titleLabel?.font = UIFont.interFont(ofSize: 16)
        button.backgroundColor = UIColor.app(.purplePrimary)
        button.tintColor = .white
        button.layer.cornerRadius = 12
        button.addTarget(OnboardingViewController.self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        setupUI()
    }
    
    
    //MARK: - Methods
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(onboardingCollectionView)
        view.addSubview(pageControl)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(nextButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        onboardingCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(120)
            make.height.equalTo(336)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(onboardingCollectionView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-174)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    @objc private func nextButtonTapped() {
        let nextIndex = min(Int(onboardingCollectionView.contentOffset.x / onboardingCollectionView.frame.width) + 1, imageNames.count - 1)
        onboardingCollectionView.scrollToItem(at: IndexPath(item: nextIndex, section: 0), at: .centeredHorizontally, animated: true)
        
        if nextIndex == imageNames.count - 1 {
            nextButton.setTitle("get_started_button".localized(), for: .normal)
        }
    }
    
    //MARK: - UIPageViewControllerDataSource
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.reuseId, for: indexPath) as! OnboardingCollectionViewCell
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.width
        let defaultSize = CGSize(width: collectionViewWidth * 0.7, height: 336)
        return defaultSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 44, bottom: 0, right: 44)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let widthImageAndSpacing = onboardingCollectionView.frame.width * 0.7 + 24
        let currentPage = Int((scrollView.contentOffset.x + onboardingCollectionView.frame.width / 2) / widthImageAndSpacing)
        pageControl.currentPage = currentPage
        
        if currentPage == imageNames.count - 1 {
            nextButton.setTitle("get_started_button".localized(), for: .normal)
            titleLabel.isHidden = true
        } else if currentPage == imageNames.count - 2 {
            nextButton.setTitle("next_button".localized(), for: .normal)
            titleLabel.isHidden = true
        } else {
            nextButton.setTitle("next_button".localized(), for: .normal)
            titleLabel.isHidden = false
        }
        // масштабирование относительно отдаления от центра
        let centerPoint = CGPoint(x: scrollView.frame.size.width / 2 + scrollView.contentOffset.x, y: scrollView.frame.size.height / 2)
        
        for cell in onboardingCollectionView.visibleCells {
            guard let indexPath = onboardingCollectionView.indexPath(for: cell) else { continue }
            let cellFrame = onboardingCollectionView.layoutAttributesForItem(at: indexPath)?.frame ?? CGRect.zero
            let distanceFromCenter = abs(cellFrame.midX - centerPoint.x)
            let scale = max(0.85, 1 - (distanceFromCenter / scrollView.frame.size.width))
            
            cell.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
}


#Preview { OnboardingViewController() }
