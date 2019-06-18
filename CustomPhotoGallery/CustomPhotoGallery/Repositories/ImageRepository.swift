//
//  ImageRepository.swift
//  CustomPhotoGallery
//
//  Created by nguyen.duc.huyb on 6/20/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import UIKit

protocol ImageRepository {
    func uploadImage(base64Image: String, completion: @escaping (BaseResult<UploadImageResponse>) -> Void)
}

final class ImageRepositoryImpl: ImageRepository {
    
    private var api: APIServices?
    
    required init(api: APIServices) {
        self.api = api
    }
    
    func uploadImage(base64Image: String, completion: @escaping (BaseResult<UploadImageResponse>) -> Void) {
        let input = UploadImageRequest(image: base64Image)
        
        api?.request(input: input) { (object: UploadImageResponse?, error) in
            if let object = object {
                completion(.success(object))
            } else if let error = error {
                completion(.failure(error: error))
            } else {
                completion(.failure(error: nil))
            }
        }
    }
}
