//
//  OnboardingViewController.swift
//  NewsToDay
//
//  Created by SM Team 6 on 20.10.24.
//

import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {
	typealias DataSource = UICollectionViewDiffableDataSource<Int, Item>

	// MARK: - UI Components
	
	private lazy var carouselSection = CarouselSection(collectionView: collectionView, pageControl: pageControl)
	
	private lazy var pageControl: CustomPageControl = {
		let pageControl = CustomPageControl()
		pageControl.numberOfPages = CarouselItems.imageNames.count
		pageControl.currentPage = 0
		return pageControl
	}()
	
	private lazy var collectionView: UICollectionView = {
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.isScrollEnabled = false
		view.delegate = self
		return view
	}()
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.font = .interFont(ofSize: 24, weight: .semibold)
		label.textAlignment = .center
		label.textColor = .app(.blackDark)
		label.text = "first_to_know".localized()
		return label
	}()
	
	private lazy var descriptionLabel: UILabel = {
		let label = UILabel()
		label.font = .interFont(ofSize: 18)
		label.textColor = .app(.greyDark)
		label.textAlignment = .center
		label.numberOfLines = 0
		label.text = "description_first".localized()
		return label
	}()

	private lazy var nextButton: UIButton = {
		let button = UIButton()
		button.setTitle("next".localized(), for: .normal)
		button.titleLabel?.font = .interFont(ofSize: 18, weight: .semibold)
		button.setTitleColor(.white, for: .normal)
		button.backgroundColor = .app(.purplePrimary)
		button.layer.cornerRadius = 20
		return button
	}()
	
	// MARK: - Lifecycle
	override func loadView() {
		super.loadView()
		setupViews()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		reloadData()
	}

	// MARK: - Layout
	private func setupViews() {
		view.backgroundColor = .white
		view.addSubview(collectionView)
		view.addSubview(pageControl)
		
		view.addSubview(titleLabel)
		view.addSubview(descriptionLabel)
		
		view.addSubview(nextButton)
		
		nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
		makeConstraints()
	}
	
	private func makeConstraints() {
		collectionView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
			make.height.equalTo(view.snp.width)
			make.left.right.equalTo(view.safeAreaLayoutGuide)
		}
		
		pageControl.snp.makeConstraints { make in
			make.top.equalTo(collectionView.snp.bottom)
			make.centerX.equalToSuperview()
			make.width.equalTo(40)
			make.height.equalTo(10)
		}
		
		nextButton.snp.makeConstraints { make in
			make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
			make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
			make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
			make.height.equalTo(60)
		}
		
		descriptionLabel.snp.makeConstraints { make in
			make.bottom.equalTo(nextButton.snp.top).offset(-40)
			make.left.equalToSuperview().offset(20)
			make.right.equalToSuperview().offset(-20)
			make.centerX.equalToSuperview()
		}
		
		titleLabel.snp.makeConstraints { make in
			
			make.bottom.equalTo(descriptionLabel.snp.top).offset(-30)
			make.centerX.equalToSuperview()
		}
	}

	private lazy var layout: UICollectionViewLayout = UICollectionViewCompositionalLayout { [self] sectionIndex, layoutEnvironment in
		
		self.carouselSection.didUpdatePage = { page in
			self.pageControl.currentPage = page
		}
		
		return self.carouselSection.layoutSection(for: sectionIndex, layoutEnvironment: layoutEnvironment)
	}

	private lazy var dataSource: DataSource = {
		let carouselCellRegistration = UICollectionView.CellRegistration<OnboardingItemCell, Item> { cell, indexPath, itemIdentifier in
			cell.configure(with: itemIdentifier.image)
		}
		let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
			collectionView.dequeueConfiguredReusableCell(using: carouselCellRegistration, for: indexPath, item: itemIdentifier)
		}
		return dataSource
	}()

	private func reloadData() {
		var snap = NSDiffableDataSourceSnapshot<Int, Item>()
		snap.appendSections([0])
		snap.appendItems(CarouselItems.makeItems())
		
		dataSource.apply(snap) { [weak self] in
			guard let self = self else { return }
			DispatchQueue.main.async {
				self.collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: false)
				self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
			}
		}
	}
	
	private func didPageChange(_ currentPage: Int) {
		let indexPath = IndexPath(item: currentPage, section: 0)
		collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
	}
	
	// MARK: - Next button methods
	private func updateElementsState(for page: Int) {
		switch page {
		case 1:
			UIView.transition(with: titleLabel, duration: 0.2, options: .transitionCrossDissolve, animations: {
				self.titleLabel.text = "stay_informed".localized()
			}, completion: nil)

			UIView.transition(with: descriptionLabel, duration: 0.2, options: .transitionCrossDissolve, animations: {
				self.descriptionLabel.text = "description_second".localized()
			}, completion: nil)
		case 2:
			UIView.transition(with: titleLabel, duration: 0.2, options: .transitionCrossDissolve, animations: {
				self.titleLabel.text = "get_started".localized()
			}, completion: nil)

			UIView.transition(with: descriptionLabel, duration: 0.2, options: .transitionCrossDissolve, animations: {
				self.descriptionLabel.text = "description_third".localized()
			}, completion: nil)
			
			UIView.transition(with: nextButton, duration: 0.2, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
				self.nextButton.setTitle("button_get_started".localized(), for: .normal)
			}, completion: nil)
			DefaultsManager.hasSeenOnboarding = true
		default:
			let registerVC = RegisterViewController()
			registerVC.modalPresentationStyle = .fullScreen
			registerVC.modalTransitionStyle = .flipHorizontal
			self.present(registerVC, animated: true)
		}
	}
	
	@objc private func nextButtonTapped() {
		carouselSection.scrollToNextPage() { nextPage in
			updateElementsState(for: nextPage)
		}
	}
}

extension OnboardingViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		carouselSection.applyTransform(to: cell, at: indexPath)
		
			
	}
}


