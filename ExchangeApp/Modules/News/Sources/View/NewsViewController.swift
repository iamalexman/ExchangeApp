//
//  NewsViewController.swift
//  ExchangeApp
//
//  Created by Alex Smith on 24.08.2022.
//

import Foundation
import UIKit

class NewsViewController: UIViewController {
    
    var presenter: NewsPresenterProtocol?
    var filteredData = [String]() // search
    let data = [String]() // search
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "News"
        navigationItem.backButtonTitle = "Exchange Rates"
        filteredData = data // search
        setup()
        
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    private lazy var backgroundView: UIView = {
       
        let view = UIView()
        
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        
        let searchView = UISearchBar()
        
        searchView.searchBarStyle = UISearchBar.Style.minimal
        searchView.placeholder = "Search news..."
        searchView.sizeToFit()
        searchView.delegate = self
        searchView.translatesAutoresizingMaskIntoConstraints = false
        
        return searchView
    }()
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.separatorStyle = .singleLine
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemBackground
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "newsCell")
        tableView.refreshControl = pullControl
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private lazy var pullControl: UIRefreshControl = {
        
        let pullControl = UIRefreshControl()

        pullControl.addTarget(self, action: #selector(pulledRefreshControl), for: .valueChanged)
        pullControl.tintColor = UIColor(named: "AccentColor")
        pullControl.backgroundColor = .systemBackground
        
        return pullControl
    }()
    
    @objc private func pulledRefreshControl(_ refreshControl: AnyObject) {
        presenter?.viewDidSrartRefreshing()
        reloadTableViewData()
        self.pullControl.endRefreshing()
    }
    
    func setup() {
        view.addSubview(backgroundView)
        view.addSubview(tableView)
        view.addSubview(searchBar)
    }
    
    func setupConstraints(){
        
        let margins = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 5),
            tableView.leftAnchor.constraint(equalTo: margins.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: margins.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: searchBar.topAnchor),

            searchBar.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            searchBar.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 5),
            searchBar.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: -5)
            
        ])
    }
}

extension NewsViewController: NewsViewProtocol {
    
    func showNews(_ news: [NewsModel]) {
        presenter?.newsModels = news
    }
    
    func reloadTableViewData() {
        tableView.reloadData()
    }
    
    func showAlert(_ message: String) {
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alertController.view.tintColor = UIColor(named: "AccentColor")
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - TableView delegate

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.newsModels.count ?? 0
//        filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell else { fatalError("NewsCell not registered") }
        cell.selectionStyle = .none
        cell.update(model: (presenter?.newsModels[indexPath.row])!)
//        cell.textLabel?.text = filteredData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - Search button delegate

extension NewsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })
        tableView.reloadData()
    }
}
