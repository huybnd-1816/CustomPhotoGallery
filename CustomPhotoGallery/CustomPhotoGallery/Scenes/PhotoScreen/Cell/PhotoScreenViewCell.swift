//
//  PhotoCollectionViewCell.swift
//  CustomPhotoGallery
//
//  Created by nguyen.duc.huyb on 6/19/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import UIKit
import Photos

final class PhotoScreenViewCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    var didChange: ((Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        
        // TapGestureRecognizer - Double tap to reset zoom scale
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGestureRecognizer))
//        tapGesture.numberOfTapsRequired = 2
//        contentView.addGestureRecognizer(tapGesture)
    }
    
//    @objc
//    fileprivate func handleTapGestureRecognizer(_ sender: UITapGestureRecognizer) {
//        if scrollView.zoomScale > scrollView.minimumZoomScale {
//            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
//        } else {
//            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
//        }
//    }
    
    func configCell(_ asset: PHAsset) {
        resetZoomScale()
        imageView.image = asset.getAsset(size: CGSize(width: self.frame.width, height: self.frame.height))
    }
    
    func resetZoomScale() {
        if scrollView.zoomScale > scrollView.minimumZoomScale {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        }
    }
}

extension PhotoScreenViewCell: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    // Disable collectionview 's scrollview when zoomming
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale <= 1.0 {
            didChange?(true)
        } else {
            didChange?(false)
        }
    }
}
