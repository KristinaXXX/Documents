//
//  LoginViewController.swift
//  My documents
//
//  Created by Kr Qqq on 30.10.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let viewModel: LoginViewModel
    private var loginMode: LoginMode? {
        didSet {
            logInButton.isEnabled = false
            logInButton.backgroundColor = .lightGray
            passwordTextField.text = nil
            switch loginMode {
            case .newLogin:
                passwordStruct = Password()
                logInButton.setTitle("Создать пароль", for: .normal)
            case .repeatLogin:
                logInButton.setTitle("Повторите пароль", for: .normal)
            case .savedLogin:
                logInButton.setTitle("Введите пароль", for: .normal)
            case .none:
                ()
            }
        }
    }
    
    private var passwordStruct = Password()

    private lazy var logInButton = CustomButton(title: "Log In", buttonAction: ( { self.logInButtonPressed() } ))
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.addTarget(self, action: #selector(passwordTextChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        loginMode = .newLogin
    }
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        startLogin()
    }
    
    func addSubviews() {
        view.addSubview(passwordTextField)
        view.addSubview(logInButton)
    }
    
    func setupConstraints() {
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant:  -20),
            passwordTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            passwordTextField.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            logInButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            logInButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func startLogin() {
        if viewModel.haveSavedPassword() {
            loginMode = .savedLogin
        } else {
            loginMode = .newLogin
        }
    }
    
    func logInButtonPressed() {
        
        switch loginMode {
        case .newLogin:
            passwordStruct.first = passwordTextField.text!
            loginMode = .repeatLogin
            return
        case .repeatLogin:
            passwordStruct.second = passwordTextField.text!
        case.savedLogin:
            passwordStruct.first = passwordTextField.text!
        default:
            return
        }
        
        viewModel.login(passwordStruct: passwordStruct, loginMode: loginMode!, completion: { [weak self] result in
            self?.loginMode = result
        })
        
    }
    
    @objc func passwordTextChanged(_ textField: UITextField) {
        logInButton.isEnabled = textField.text?.count ?? 0 >= 4
        if logInButton.isEnabled {
            logInButton.backgroundColor = .systemBlue
        } else {
            logInButton.backgroundColor = .lightGray
        }
    }

}
