//
//  RecSearchViewController.swift
//  NewsToDay
//
//  Created by Anna Melekhina on 25.10.2024.
//

import UIKit

final class RecSearchViewController: TitlesBaseViewController {
    
    var articlesData: [NewsModel] = []
    
    //MARK: - Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 112
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .cyan

        setupTableView()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
            }
    
    
    //MARK: - SetupUI
    private func setupTableView() {
        tableView.register(RecSearchViewControllerCell.self, forCellReuseIdentifier: RecSearchViewControllerCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        
        setTitlesNavBar(title: "What we’ve found for you", description: "")
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.2),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
        
         
    
    //MARK: - Methods
    func updateUI() {
        tableView.reloadData()
        
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension RecSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecSearchViewControllerCell.reuseID, for: indexPath) as? RecSearchViewControllerCell else {
                return UITableViewCell()
            }
            let article = articlesData[indexPath.row]
            cell.set(article: article) // Передаем данные статьи в ячейку
            return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedArticle = articlesData[indexPath.row]
            let destVC = ArticleViewController()
        destVC.article = selectedArticle
             
            navigationController?.pushViewController(destVC, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    
}
 


