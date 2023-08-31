//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Никита on 22.05.2023.
//

import UIKit

class PhotosViewController: UIViewController {
    let layout = UICollectionViewFlowLayout()
    var myCollectionView: UICollectionView!
    let imageNames = DataService.array

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray

        myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.view.addSubview(myCollectionView)
        myCollectionView.backgroundColor = .lightGray
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.title = "Photo Gallery"
        self.navigationController?.navigationBar.isHidden = false
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        setupConstraints()

    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([

            myCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8),
            myCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            myCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            myCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8)

        ])
    }
    
}

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! PhotosCollectionViewCell
        let element = imageNames[indexPath.row]
        print(element)
        cell.setImage(imageName: element)
        cell.contentView.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 8
        let cellSize = collectionView.frame.width - padding * 3
        return CGSize(width: cellSize/3, height: cellSize/3)
    }
    
}

