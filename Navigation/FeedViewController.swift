//
//  FeedViewController.swift
//  Navigation
//
//  Created by Никита on 16.02.2023.
//
import UIKit

class FeedViewController: UIViewController {
    
    private let newPostTitle = "Latest News"
    
    let stackView: UIStackView = {
        
        let view = UIStackView()
        view.axis = .vertical // Вертикальное расположение элементов
        view.alignment = .center // Центрирование элементов
        view.distribution = .fillEqually // Правило заполнения стека
        view.spacing = 10 // Отступы между элементами (Подпараметр 17 строки)
        
        return view
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Go to post", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        // button.translatesAutoresizingMaskIntoConstraints = false
        button.frame = CGRect(x: 0, y: 0, width: 150, height: 40)
        
        return button
    }()

    private lazy var button2: UIButton = {
        let button = UIButton()
        button.setTitle("Go to post", for: .normal)
        button.backgroundColor = .systemYellow
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        // button.translatesAutoresizingMaskIntoConstraints = false
        button.frame = CGRect(x: 0, y: 0, width: 150, height: 40)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
        view.backgroundColor = .black
        #else
        view.backgroundColor = .white
        #endif
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
   //     view.addSubview(button)
        view.addSubview(stackView)
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(button2)
        
    }

    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }

    @objc private func tapButton() {
        let postViewController = PostViewController()
        postViewController.postTitle = newPostTitle
        navigationController?.pushViewController(postViewController, animated: true)
    }
}


