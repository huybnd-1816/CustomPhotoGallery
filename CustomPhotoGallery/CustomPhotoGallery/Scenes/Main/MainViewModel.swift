//
//  MainViewModel.swift
//  CustomPhotoGallery
//
//  Created by nguyen.duc.huyb on 6/17/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import Photos
import IHProgressHUD

class MainViewModel: BaseViewModel {
    private var albums: [PHAssetCollection] = [] {
        didSet {
            didChange?(.success)
        }
    }
    
    var count: Int {
        return albums.count
    }
    
    subscript(index: Int) -> PHAssetCollection? {
        return albums[index]
    }
    
    private var didChange: ((Result) -> Void)?
    
    func bind(didChange: @escaping (Result) -> Void) {
        self.didChange = didChange
    }
    
    func reloadData() {
        PHAssetCollection.getAssetCollections { [weak self] result in
            guard let self = self else { return }
            self.albums = result
        }
    }
}
