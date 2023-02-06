//
//  CurrencyPairsRatesViewController.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 18.07.2022.
//

import UIKit

class CurrencyPairsRatesViewController: UIViewController {
    
    var presenter: CurrencyPairsRatesPresenterProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Exchange Rates"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "newspaper"), style: .done, target: self, action: #selector(newsBarButton))
        
        presenter?.viewDidLoad()
        
        setup()
        
        setupConstraints()
    }
    
    // MARK: - Outlets
    
    @objc private func newsBarButton() {
        presenter?.goToNewsViewController()
    }
    
    private lazy var backgroundView: UIView = {
       
        let view = UIView()
        
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemBackground
        tableView.register(CurrencyPairsRatesTableViewCell.self, forCellReuseIdentifier: "currencyCell")
        tableView.refreshControl = pullControl
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
        self.pullControl.endRefreshing()
    }
    
    private lazy var addButton: UIButton = {
        
        let imageView = UIImageView()
        let image = UIImage(named: "Plus")
        let button = UIButton(type: UIButton.ButtonType.custom)

        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let hintTitle: UILabel = {
        
        let label = UILabel()
        
        label.text = "Сlick plus button to get the course"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addButtonLabel: UILabel = {
        
        let label = UILabel()
        
        label.text = "Add Currency Pair"
        label.textAlignment = .center
        label.textColor = UIColor(named: "AccentColor")
        label.font = UIFont.systemFont(ofSize: label.font!.pointSize, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var blurView: UIVisualEffectView = {
        
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        
        blurView.backgroundColor = .lightGray.withAlphaComponent(0.3)
        blurView.layer.cornerRadius = 20
        blurView.clipsToBounds = true
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()

    // MARK: - Action
    
    @objc private func buttonAction(_ sender: UIButton!) {  // Plus button action segueu to present SelectedView
        presenter?.showCurrencyPairSelector()
    }

    // MARK: - Setup
    
    private func setup() {
        view.addSubview(backgroundView)
        view.addSubview(tableView)
        view.addSubview(hintTitle)
        view.addSubview(blurView)
        view.addSubview(addButton)
        view.addSubview(addButtonLabel)
    }
    
    // MARK: - Setup Constraits
    
    func setupConstraints() {
        
        let margins = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            blurView.topAnchor.constraint(equalTo: addButton.topAnchor, constant: -10),
            blurView.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 25),
            blurView.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: -25),
            blurView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            
            hintTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hintTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65),
            addButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            addButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            addButton.widthAnchor.constraint(equalTo: margins.widthAnchor),

            addButtonLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            addButtonLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            addButtonLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            addButtonLabel.widthAnchor.constraint(equalTo: margins.widthAnchor),
                        
            tableView.topAnchor.constraint(equalTo: margins.topAnchor),
            tableView.leftAnchor.constraint(equalTo: margins.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: margins.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: blurView.topAnchor)
        ])
    }
}

extension CurrencyPairsRatesViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Configuration View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = presenter?.currencyPairs.count else { return 0 }
        if count > 0 {
            hintTitle.removeFromSuperview()
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as? CurrencyPairsRatesTableViewCell else { fatalError("PairCell not registered") }
        cell.currency = presenter?.currencyPairs[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellToDeSelect: UITableViewCell = tableView.cellForRow(at: indexPath)!
        cellToDeSelect.contentView.backgroundColor = .systemBackground
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pairItem = presenter?.currencyPairs[indexPath.row]
            presenter?.removeCurrencyPair(pairItem!)
        }
    }
}

extension CurrencyPairsRatesViewController: CurrencyPairsRatesViewProtocol {
    
    // MARK: - View Protocol
    
    func showCurrencyPairs(_ pairs: [CurrencyPair]) {
        presenter?.currencyPairs = pairs
        tableView.reloadData()
    }

    func showErrorMessage(_ message: String) {
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alertController.view.tintColor = UIColor(named: "AccentColor")
        present(alertController, animated: true, completion: nil)
    }
    
    func reloadTableViewData() {
        tableView.reloadData()
    }
}
