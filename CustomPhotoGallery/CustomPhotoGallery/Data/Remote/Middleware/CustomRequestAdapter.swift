//
//  CustomRequestAdapter.swift
//  CustomPhotoGallery
//
//  Created by nguyen.duc.huyb on 6/20/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import Alamofire

final class CustomRequestAdapter: RequestAdapter {
    private var headers = Alamofire.SessionManager.defaultHTTPHeaders
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue(APIKey.clientID.rawValue, forHTTPHeaderField: "Authorization")
        return urlRequest
    }
}
