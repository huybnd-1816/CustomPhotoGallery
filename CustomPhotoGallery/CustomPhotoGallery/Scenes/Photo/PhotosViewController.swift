//
//  PhotosViewController.swift
//  CustomPhotoGallery
//
//  Created by nguyen.duc.huyb on 6/17/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import UIKit
import Photos

final class PhotosViewController: UIViewController {
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    private var viewModel: PhotosViewModel!
    private var numberOfItemsInRow: Int = 4
    private var selectedAlbum: PHAssetCollection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Scroll to last cell
        DispatchQueue.main.async {
            self.view.layoutIfNeeded()
            self.photosCollectionView.scrollToLastCell(animated: false)
        }
    }
    
    private func config() {
        navigationItem.largeTitleDisplayMode = .never
        
        photosCollectionView.register(UINib.init(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        viewModel.bind { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.photosCollectionView.reloadData()
            }
        }
    }
    
    func bindingData(data: PHAssetCollection) {
        navigationItem.title = data.localizedTitle
        selectedAlbum = data
        viewModel = PhotosViewModel()
        viewModel.selectedCollection = data
        viewModel.reloadData()
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photosCollectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        guard let data = viewModel[indexPath.row] else { return UICollectionViewCell() }
        cell.configCell(data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PhotoScreenViewController") as! PhotoScreenViewController
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        vc.index = indexPath.row
        vc.setupData(viewModel)
        present(vc, animated:true, completion: nil)
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    // Min spacing between items in a section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    // Min spacing between rows or columns in a section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    // Margin content in section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    // Size For Item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (Int(UIScreen.main.bounds.size.width) - (numberOfItemsInRow - 1) * 2) / numberOfItemsInRow
        return CGSize(width: width, height: width)
    }
}
