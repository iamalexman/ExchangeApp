//
//  CurrencyPairSelectorViewController.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 18.07.2022.
//

import UIKit

class CurrencyPairSelectorViewController: UIViewController {
    
    // MARK: - Dependency
    
    var presenter: CurrencyPairSelectorPresenterProtocol?
    
    // MARK: - Outlet
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CurrencyPairSelectorTableViewCell.self, forCellReuseIdentifier: "currencyCell")
        return tableView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        
        navigationItem.title = "Валютные пары"
        
        setup()
        
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        presenter?.viewWillAppear()
    }
    
    func setup() {
        view.addSubview(tableView)
    }
    
    // MARK: - Constraint Configuration
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension CurrencyPairSelectorViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Configuration View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.localCurrencyList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as? CurrencyPairSelectorTableViewCell else { fatalError("CurrencyCell not registered") }
        cell.update(model: (presenter?.localCurrencyList[indexPath.row])!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.toggleSelectModel(indexPath: indexPath)
        tableView.reloadData()
    }
}


extension CurrencyPairSelectorViewController: CurrencyPairSelectorViewProtocol {
    
    // MARK: - ViewProtocol

    func showList(_ currencies: [CurrencyTableViewCellModel]) {
        presenter?.localCurrencyList = currencies
    }
    
    func showError(_ message: String) {
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alertController.view.tintColor = UIColor(named: "AccentColor")
        present(alertController, animated: true, completion: nil)
    }
    
    func reloadTableViewData() {
        tableView.reloadData()
    }
}
