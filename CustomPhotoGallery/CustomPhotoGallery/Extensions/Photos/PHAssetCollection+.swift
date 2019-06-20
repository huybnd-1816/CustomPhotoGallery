//
//  PHAssetCollection.swift
//  CustomPhotoGallery
//
//  Created by nguyen.duc.huyb on 6/17/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import Photos

extension PHAssetCollection {
    
    // Get all asset collection (album) in photo gallery
    static func getAssetCollections(completion: @escaping ([PHAssetCollection]) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { 
            var albums = [PHAssetCollection]()
            
            let result = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil) // fetch all asset collections in photo gallery
            DispatchQueue.main.async {
                result.enumerateObjects({ (collection, _, _) in
                    if (collection.hasAssets()) {
                        albums.append(collection)
                    }
                })
                // Sorting albums
                albums = albums.sorted {
                    $0.localizedTitle! < $1.localizedTitle!
                }
                
                completion(albums)
            }
        }
    }
    
    static func fetchImagesFromGallery(collection: PHAssetCollection?, completion: @escaping (PHFetchResult<PHAsset>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let fetchOptions = PHFetchOptions()
            fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
            var photos = PHFetchResult<PHAsset>()
            
            DispatchQueue.main.async {
                if let collection = collection {
                    photos = PHAsset.fetchAssets(in: collection, options: fetchOptions)
                } else {
                    photos = PHAsset.fetchAssets(with: fetchOptions)
                }
                completion(photos)
            }
        }
    }
    
    // Check an album has asset or not
    // An asset represent an image, a livephoto or a video
    func hasAssets() -> Bool {
        let assets = PHAsset.fetchAssets(in: self, options: nil)  //fetch all the assets in an asset collection
        return assets.count > 0
    }
    
    // Get cover image for cell
    func getCoverImgWithSize(_ size: CGSize) -> UIImage! {
        let assets = PHAsset.fetchAssets(in: self, options: nil)
        let asset = assets.lastObject
        return asset?.getAssetThumbnail(size: size)
    }
    
    // Get number of photos in an asset collection
    var photosCount: Int {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "mediaType == %d", PHAssetMediaType.image.rawValue)
        let result = PHAsset.fetchAssets(in: self, options: fetchOptions)
        return result.count
    }
}
