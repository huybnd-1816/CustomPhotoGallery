//
//  PhotosViewModel.swift
//  CustomPhotoGallery
//
//  Created by nguyen.duc.huyb on 6/17/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import Photos
import IHProgressHUD

final class PhotosViewModel: BaseViewModel {
    private let repoRepository = ImageRepositoryImpl(api: APIServices.shared)
    var selectedCollection: PHAssetCollection?
    
    private var photos = PHFetchResult<PHAsset>() {
        didSet {
            didChange?(.success)
        }
    }
    
    var count: Int {
        return photos.count
    }
    
    subscript(index: Int) -> PHAsset? {
        return photos.object(at: index)
    }
    
    private var didChange: ((Result) -> Void)?
    var bindData: ((PHAssetCollection) -> Void)?
    
    func bind(didChange: @escaping (Result) -> Void) {
        self.didChange = didChange
    }
    
    func reloadData() {
        PHAssetCollection.fetchImagesFromGallery(collection: selectedCollection) { [weak self] result in
            guard let self = self else { return }
            self.photos = result
        }
    }
    
    func uploadData(index: Int) {
        let asset = photos.object(at: index)
        let image = asset.getAsset(size: CGSize(width: 128, height: 128))
        let base64Image: String! = image.convertImageToBase64()
        
        
        
        IHProgressHUD.show()
        repoRepository.uploadImage(base64Image: base64Image) { result in
            IHProgressHUD.dismiss()
            switch result {
            case .success(let response):
                guard let data = response?.data else { return }
                print(data)
                IHProgressHUD.showSuccesswithStatus("Image has uploaded successful")
            case .failure(let error):
                IHProgressHUD.showError(withStatus: error?.errorMessage)
            }
        }
    }
}
