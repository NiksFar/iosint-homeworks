//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Никита on 22.05.2023.
//

import UIKit
import iOSIntPackage // Добавлена зависимость

class PhotosViewController: UIViewController {

    let imagePublisherFacade = ImagePublisherFacade()
    
    let layout = UICollectionViewFlowLayout()
    var myCollectionView: UICollectionView!
    private var imageNames = DataService.array
    private var photos = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageNames.forEach{
            photos.append(UIImage(named: $0)!)
        }
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
        
        imageFiltered()
        subscribe()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([

            myCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8),
            myCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            myCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            myCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8)

        ])
    }
    
    private func subscribe() {
        imagePublisherFacade.subscribe(self)
    }
    
    private func unsubscribe() {
        imagePublisherFacade.removeSubscription(for: self)
    }
    
    private func imageFiltered() {
        imagePublisherFacade.addImagesWithTimer(time: 0.5, repeat: 12, userImages: photos)
    }
    
}

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! PhotosCollectionViewCell
        
        let element = photos[indexPath.row]
        print(element)
        cell.setupImage(image: element)
        cell.contentView.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 8
        let cellSize = collectionView.frame.width - padding * 3
        return CGSize(width: cellSize/3, height: cellSize/3)
    }
    
}

extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        photos = images
        print("here it is, \(images.count) elements", photos.count)
        if images.count == 12 { unsubscribe()}
        myCollectionView.reloadData()
    }
}
