//
//  BookmarksViewController.swift
//  NewsToDay
//
//  Created by SM Team 6 on 20.10.24.
//

import UIKit

final class BookmarksViewController: TitlesBaseViewController {
    
    //MARK: - Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 112
        return tableView
    }()
    
    private let emptyView: BookmarkEmptyView = {
        let view = BookmarkEmptyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    //TEST DATA
    //private var bookmarks = BookmarksTests.data
    //private var bookmarks = [Bookmark]()
    
    private var bookmarks = [NewsModel]()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBookmarks()
        addObserverForLocalization()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserverForLocalization()
    }
    
    //MARK: - SetupUI
    private func setupTableView() {
        tableView.register(BookmarksCell.self, forCellReuseIdentifier: BookmarksCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(emptyView)
        
        setTitlesNavBar(title: "bookmarks_screen_title".localized(), description: "description_bookmarks_title".localized())
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.2),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            emptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
        ])
    }
    
    //MARK: - Methods
    private func getBookmarks() {
        PersistenceManager.retrieveBookmarks { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let bookmarks):
                DispatchQueue.main.async {
                    self.updateUI(with: bookmarks)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updateUI(with bookmarks: [NewsModel]) {
        if bookmarks.isEmpty {
            emptyView.isHidden = false
        } else {
            emptyView.isHidden = true
            self.bookmarks = bookmarks
            DispatchQueue.main.async {
                self.tableView.reloadData()
                //if we have before empty state, show tableview exactly
                self.view.bringSubviewToFront(self.tableView)
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
    
    @objc private func updateLocalizedText() {
        setTitlesNavBar(title: "bookmarks_screen_title".localized(), description: "description_bookmarks_title".localized())
        emptyView.updateEmptyText()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarksCell", for: indexPath) as? BookmarksCell else {
            return UITableViewCell()
        }
        let bookmark = bookmarks[indexPath.row]
        cell.set(bookmark: bookmark)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookmark = bookmarks[indexPath.row]
        let destVC = ArticleViewController()
        destVC.article = bookmark
        
        navigationController?.pushViewController(destVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        PersistenceManager.updateWith(bookmark: bookmarks[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                //update favorites only if we have success persistence update
                bookmarks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            print(error)
        }
    }
}

#Preview {
    BookmarksViewController()
}
