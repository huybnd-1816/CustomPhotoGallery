//
//  UICollectionView+.swift
//  CustomPhotoGallery
//
//  Created by nguyen.duc.huyb on 6/18/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import UIKit

extension UICollectionView {
    func scrollToLastCell(animated : Bool) {
        let lastSection = numberOfSections - 1
        guard lastSection >= 0 else { return }
        let lastItem = numberOfItems(inSection: lastSection) - 1
        guard lastItem >= 0 else { return }
        let lastItemIndexPath = IndexPath(item: lastItem, section: lastSection)
        scrollToItem(at: lastItemIndexPath, at: [.centeredVertically, .centeredHorizontally], animated: animated)
    }
    
    func scrollToSpecifiedCell(index: Int, animated: Bool) {
        let sectionIndex = self.numberOfSections - 1
        guard sectionIndex >= 0 else { return }
        let indexPath = self.numberOfItems(inSection: sectionIndex) - 1
        guard indexPath >= 0 else { return }
        self.scrollToItem(at: IndexPath(row: index, section: sectionIndex), at: [.centeredVertically, .centeredHorizontally], animated: animated)
    }
}
