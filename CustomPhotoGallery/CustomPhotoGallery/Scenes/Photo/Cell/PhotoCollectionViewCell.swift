//
//  PhotoCollectionViewCell.swift
//  CustomPhotoGallery
//
//  Created by nguyen.duc.huyb on 6/17/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import UIKit
import Photos

final class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var photoImageView: UIImageView!
    
    func configCell(_ asset: PHAsset) {
        photoImageView.image = asset.getAssetThumbnail(size: CGSize(width: self.frame.width * 3, height: self.frame.height * 3))
    }
}
