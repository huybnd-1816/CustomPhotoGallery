//
//  PHPhotoLibrary.swift
//  CustomPhotoGallery
//
//  Created by nguyen.duc.huyb on 6/17/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import Photos

extension PHPhotoLibrary {
    
    // Check Photo Gallery Authorization
    static func checkAuthorizationStatus(completion: @escaping (_ status: Bool) -> Void) {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            completion(true)
        } else {
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                if newStatus == PHAuthorizationStatus.authorized {
                    completion(true)
                } else {
                    completion(false)
                }
            })
        }
    }
    
    // Save image and metadata in photo gallery
    static func saveImage(image: UIImage?, location: CLLocation?) {
        // Make sure the image is not nil
        guard let image = image else {
            return
        }
        
        // Perform changes to the library
        PHPhotoLibrary.shared().performChanges({
            let creationRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            guard let location = location else { return }
            creationRequest.location = location // Save location to image's metadata
        }, completionHandler: { success, error in
            if success {
                print("Save Image Successful")
            } else {
                print("Save Error: \(error?.localizedDescription)")
            }
        })
    }
}
