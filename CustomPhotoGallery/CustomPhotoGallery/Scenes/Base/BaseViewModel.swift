//
//  BaseViewModel.swift
//  CustomPhotoGallery
//
//  Created by nguyen.duc.huyb on 6/17/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import Photos

enum Result {
    case success
    case failure(error: Error)
}

protocol BaseViewModel {
    func bind(didChange: @escaping (Result) -> Void)
    func reloadData()
}
