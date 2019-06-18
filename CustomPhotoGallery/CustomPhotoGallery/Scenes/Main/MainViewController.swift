//
//  ViewController.swift
//  CustomPhotoGallery
//
//  Created by nguyen.duc.huyb on 6/17/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import UIKit
import Photos

final class MainViewController: UIViewController {
    @IBOutlet private weak var albumCollectionView: UICollectionView!
    
    private var viewModel: MainViewModel!
    private var numberOfItemsInRow: Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        checkAutorizationStatus()
    }
    
    private func config() {
        viewModel = MainViewModel()
        navigationItem.title = "Album"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        albumCollectionView.register(UINib.init(nibName: "AlbumCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AlbumCell")
        viewModel.bind { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.albumCollectionView.reloadData()
            }
        }
    }
    
    private func checkAutorizationStatus() {
        PHPhotoLibrary.checkAuthorizationStatus { [weak self] status in
            guard let self = self else { return }
            if status {
                self.viewModel.reloadData()
            } else {
                self.showAlert(message: CommonError.AuthorIsDenied.rawValue)
            }
        }
    }
    
    @IBAction func handleCameraButtonTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CameraViewController") as! CameraViewController
        self.present(vc, animated: true, completion: nil)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as! AlbumCollectionViewCell
        guard let album = viewModel[indexPath.row] else { return UICollectionViewCell() }
        cell.configCell(album)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PhotosViewController") as! PhotosViewController
        guard let album = viewModel[indexPath.row] else { return }
        vc.bindingData(data: album)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    // Min spacing between items in a section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    // Min spacing between rows or columns in a section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // Margin content in section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    // Size For Item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (Int(UIScreen.main.bounds.size.width) - (numberOfItemsInRow - 1) * 20 - 40) / numberOfItemsInRow
        return CGSize(width: width, height: width * 3/2)
    }
}
