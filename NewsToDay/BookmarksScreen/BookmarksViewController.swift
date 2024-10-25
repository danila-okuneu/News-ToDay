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
    private var bookmarks = BookmarksTests.data
    //private var bookmarks = [Bookmark]()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI(with: bookmarks)
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
        
        setTitlesNavBar(title: "Bookmarks", description: "Saved articles to the library")
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
    func updateUI(with bookmarks: [Bookmark]) {
        if bookmarks.isEmpty {
            emptyView.isHidden = false
        } else {
            emptyView.isHidden = true
            self.bookmarks = bookmarks
            tableView.reloadData()
        }
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
        let _ = bookmarks[indexPath.row]
        let destVC = ArticleViewController()
        
        navigationController?.pushViewController(destVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        bookmarks.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
    }
}

#Preview {
    BookmarksViewController()
}
