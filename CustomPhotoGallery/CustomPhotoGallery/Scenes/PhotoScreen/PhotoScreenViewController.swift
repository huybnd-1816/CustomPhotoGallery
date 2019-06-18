//
//  PhotoScreenViewController.swift
//  CustomPhotoGallery
//
//  Created by nguyen.duc.huyb on 6/19/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import UIKit
import Photos
import IHProgressHUD

final class PhotoScreenViewController: ViewControllerPannable {
    @IBOutlet private weak var photoCollectionView: UICollectionView!
    @IBOutlet private weak var topBarView: UIView!
    
    private var viewModel: PhotosViewModel!
    var index: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config() {
        photoCollectionView.register(UINib.init(nibName: "PhotoScreenViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoScreenCell")
        topBarView.alpha = 0
        scrollToItem()
        
        // TapGestureRecognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGestureRecognizer))
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        
        // Pan to hide top bar
        didHideTopBar = {
            self.topBarView.fadeOut()
        }
    }
    
    @objc
    private func handleTapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        if topBarView.alpha == 0 {
            topBarView.fadeIn()
        } else {
            topBarView.fadeOut()
        }
    }
    
    func setupData(_ vm: PhotosViewModel) {
        viewModel = vm
    }

    func scrollToItem() {
        // Scroll to last cell
        DispatchQueue.main.async {
            self.view.layoutIfNeeded()
            self.photoCollectionView.scrollToSpecifiedCell(index: self.index, animated: false)
        }
    }
    
    @IBAction private func handleUploadButtonTapped(_ sender: Any) {
        viewModel?.uploadData(index: index)
    }
    
    // Get visible cell's index
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        DispatchQueue.main.async {
            if let indexPath = self.photoCollectionView.indexPathsForVisibleItems.first {
                self.index = indexPath.row
            }
        }
    }
}

extension PhotoScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: "PhotoScreenCell", for: indexPath) as! PhotoScreenViewCell
        guard let data = viewModel[indexPath.row] else { return UICollectionViewCell() }
        cell.configCell(data)
        cell.didChange = { [weak self] isDragged in
            guard let self = self else { return }
            self.photoCollectionView.isScrollEnabled = isDragged
        }
        return cell
    }
}

extension PhotoScreenViewController: UICollectionViewDelegateFlowLayout {
    // Min spacing between items in a section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    // Min spacing between rows or columns in a section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    // Margin content in section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    // Size For Item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return photoCollectionView.frame.size
    }
}
