//
//  UploadImageRequest.swift
//  CustomPhotoGallery
//
//  Created by nguyen.duc.huyb on 6/20/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import Alamofire

final class UploadImageRequest: BaseRequest {
    required init(image: String) {
        let parameters: [String: Any]  = [
            "image": image
        ]
        super.init(url: Urls.basePath, requestType: .post, parameters: parameters)
    }
}
