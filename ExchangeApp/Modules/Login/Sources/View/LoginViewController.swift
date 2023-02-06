//
//  LoginViewController.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 23.08.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Dependency
    
    var presenter: LoginPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        greetingPersonLabel.text = presenter?.viewDidLoad()
        
        navigationItem.backButtonTitle = "Logout"
        
        setup()
        
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        toggleLabels()
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    func toggleLabels() {
        if greetingPersonLabel.text != "" {
            loginButtonLabel.text = "Continue"
            usernameTitle.text = greetingPersonLabel.text
            passwordTitle.text = "password" // Some value need to change from StoreService
            usernameTitle.removeFromSuperview()
            passwordTitle.removeFromSuperview()
        } else {
            loginButtonLabel.text = "Sign in"
            greetingPersonLabel.text = ""
            usernameTitle.text = ""
            passwordTitle.text = ""
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    private lazy var loginView: UIView = {

        let loginView = UIView()
        
        loginView.backgroundColor = .systemBackground
        loginView.translatesAutoresizingMaskIntoConstraints = false
        return loginView
    }()
    
    private let greetingLabel: UILabel = {
        
        let label = UILabel()
        
        label.text = "Welcome"
        label.textColor = UIColor(named: "AccentColor")
        label.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let greetingPersonLabel: UILabel = {
        
        let label = UILabel()
        
        label.text = ""
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var usernameTitle: UITextField = {
       
        let username = UITextField()
        
        username.placeholder = "Username"
        username.textAlignment = .center
        username.translatesAutoresizingMaskIntoConstraints = false
        username.layer.cornerRadius = 10
        username.layer.borderWidth = 0.5
        username.layer.borderColor = UIColor(ciColor: .gray).cgColor
        
        return username
    }()
    
    private var passwordTitle: UITextField = {
       
        let password = UITextField()
        
        password.placeholder = "Password"
        password.textAlignment = .center
        password.layer.cornerRadius = 10
        password.layer.borderWidth = 0.5
        password.layer.borderColor = UIColor(ciColor: .gray).cgColor
        password.translatesAutoresizingMaskIntoConstraints = false
        password.isSecureTextEntry = true
        
        return password
    }()
    
    private let loginButtonLabel: UILabel = {
        
        let label = UILabel()
        
        label.text = "Sign in"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        
        let button = UIButton(type: UIButton.ButtonType.custom)
        
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = UIColor(named: "AccentColor")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    @objc private func buttonAction(_ sender: UIButton!) {
        
        UIView.animate(withDuration: 0.5, animations: {
            sender.backgroundColor = .systemBackground
            sender.backgroundColor = UIColor(named: "AccentColor")
        })
        greetingPersonLabel.text = presenter?.loginCheck(login: usernameTitle.text, password: passwordTitle.text)
        shakeTextField(textField: passwordTitle)
        shakeTextField(textField: usernameTitle)
        toggleLabels()
    }

    private lazy var exitButton: UIButton = {
        
        let button = UIButton(type: UIButton.ButtonType.custom)
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        
        button.addTarget(self, action: #selector(exitButtonAction), for: .touchUpInside)
        button.setImage(UIImage(systemName: "square.and.arrow.down", withConfiguration: boldConfig), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.transform = button.transform.rotated(by: .pi * 1.5)
        return button
    }()
    
    private let exitButtonLabel: UILabel = {
        
        let label = UILabel()
        
        label.text = "Logout"
        label.textAlignment = .center
        label.textColor = UIColor(named: "AccentColor")
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @objc private func exitButtonAction(_ sender: UIButton!) {
        
        UIView.animate(withDuration: 0.5, animations: {
            sender.backgroundColor = .systemBackground
        })
        presenter?.exitButtonPressed()
        greetingPersonLabel.text = ""
        toggleLabels()
        viewDidLoad()
    }
    
    func setup() {
        
        view.addSubview(loginView)
        
        view.addSubview(greetingLabel)
        view.addSubview(greetingPersonLabel)
        
        view.addSubview(usernameTitle)
        view.addSubview(passwordTitle)
        
        view.addSubview(exitButtonLabel)
        view.addSubview(exitButton)
        
        view.addSubview(loginButton)
        view.addSubview(loginButtonLabel)
        
    }
    
    func setupConstraints() {
        
        let margins = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            loginView.leftAnchor.constraint(equalTo: view.leftAnchor),
            loginView.rightAnchor.constraint(equalTo: view.rightAnchor),
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            greetingLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            greetingLabel.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: -140),
            
            greetingPersonLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            greetingPersonLabel.centerYAnchor.constraint(equalTo: greetingLabel.centerYAnchor, constant: 50),
   
            exitButton.heightAnchor.constraint(equalToConstant: 20),
            exitButton.widthAnchor.constraint(equalToConstant: 20),
            exitButton.leftAnchor.constraint(equalTo: margins.centerXAnchor, constant: 20),
            exitButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            
            exitButtonLabel.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: -40),
            exitButtonLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor, constant: -15),
            exitButtonLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 18),

            usernameTitle.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 25),
            usernameTitle.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: -25),
            usernameTitle.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            usernameTitle.topAnchor.constraint(equalTo: greetingLabel.topAnchor, constant:  100),
            usernameTitle.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTitle.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 25),
            passwordTitle.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: -25),
            passwordTitle.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            passwordTitle.topAnchor.constraint(equalTo: usernameTitle.bottomAnchor, constant: 10),
            passwordTitle.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 25),
            loginButton.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: -25),
            loginButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 200),
            
            loginButtonLabel.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            loginButtonLabel.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor)
        ])
    }
}

extension LoginViewController: LoginViewProtocol {
    func showAlert(_ message: String) {
        
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alertController.view.tintColor = UIColor(named: "AccentColor")
        present(alertController, animated: true, completion: nil)
    }
}

extension LoginViewController {
    func shakeTextField(textField: UITextField) {
        
        let animation = CABasicAnimation(keyPath: "position")
        
        animation.duration = 0.09
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - 5, y: textField.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 5, y: textField.center.y))
        textField.layer.add(animation, forKey: "position")
    }
}
