//
//  UIImage+.swift
//  CustomPhotoGallery
//
//  Created by nguyen.duc.huyb on 6/20/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import UIKit

extension UIImage {
    func convertImageToBase64() -> String {
        let imageData = self.pngData()!
        let base64Image = imageData.base64EncodedString(options: .lineLength64Characters)
        return base64Image
    }
}
