//
//  BaseResult.swift
//  CustomPhotoGallery
//
//  Created by nguyen.duc.huyb on 6/20/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

enum BaseResult<T: Decodable> {
    case success(T?)
    case failure(error: BaseError?)
}
