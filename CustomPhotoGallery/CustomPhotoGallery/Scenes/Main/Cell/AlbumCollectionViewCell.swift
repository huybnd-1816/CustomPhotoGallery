//
//  AlbumCollectionViewCell.swift
//  CustomPhotoGallery
//
//  Created by nguyen.duc.huyb on 6/17/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import UIKit
import Photos

final class AlbumCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var albumImageView: UIImageView!
    @IBOutlet private weak var albumTitleLabel: UILabel!
    @IBOutlet private weak var numOfPhotosLabel: UILabel!
    
    func configCell(_ album: PHAssetCollection) {
        albumTitleLabel.text = album.localizedTitle
        numOfPhotosLabel.text = String(album.photosCount)
        albumImageView.image = album.getCoverImgWithSize(albumImageView?.frame.size ?? CGSize(width: 45.0, height: 45.0))
    }
}
