//
//  LogInViewController.swift
//  Navigation
//
//  Created by Никита on 28.04.2023.
//

import UIKit

class LogInViewController: UIViewController {
    
    var logo: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "logo")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let separateView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        stackView.layer.masksToBounds = true
        stackView.layer.borderWidth = 0.5
        stackView.layer.backgroundColor = UIColor.gray.cgColor
        stackView.layer.cornerRadius = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
        
    }()
    
    var loginTF: UITextField = {
        
        let textField = TextFieldWithPadding()
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "E-mail or phone"
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16)
        textField.backgroundColor = UIColor.systemGray5
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
        
    }()
    
    var passwordTF: UITextField = {
        
        let textField = TextFieldWithPadding()
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "Password"
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16)
        textField.backgroundColor = UIColor.systemGray5
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
        
    }()
    
    let logInButton: UIButton = {
        
        let button = UIButton()
        
        let alphaImage = UIImage(named: "pixelImage")
        
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        
        button.setBackgroundImage(UIImage(named: "pixelImage"), for: .normal)
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Обработка нажатия кнопки
    @objc func buttonPressed() {
        
        let vc = ProfileViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: UIView = {
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        setupView()
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            view.endEditing(true) 
        }
    
    private func setupView() {
        
        self.view.addSubview(scrollView)
        self.view.addSubview(contentView)
        self.view.addSubview(logo)
        self.view.addSubview(stackView)
        self.view.addSubview(logInButton)
        stackView.addArrangedSubview(loginTF)
        stackView.addArrangedSubview(separateView)
        stackView.addArrangedSubview(passwordTF)
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            logo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            logo.heightAnchor.constraint(equalToConstant: 100),
            logo.widthAnchor.constraint(equalToConstant: 100),
            
            stackView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 80),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            separateView.heightAnchor.constraint(equalToConstant: 0.5),
            loginTF.heightAnchor.constraint(equalTo: passwordTF.heightAnchor, multiplier: 1),
            
            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            
        ])
    }
    
}
