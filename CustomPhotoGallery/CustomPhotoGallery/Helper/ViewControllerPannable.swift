//
//  ViewControllerPannable.swift
//  CustomPhotoGallery
//
//  Created by nguyen.duc.huyb on 6/20/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import UIKit

class ViewControllerPannable: UIViewController {
    private var panGestureRecognizer: UIPanGestureRecognizer?
    private var originalPosition: CGPoint?
    private var currentPositionTouched: CGPoint?
    
    var didHideTopBar: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        view.addGestureRecognizer(panGestureRecognizer!)
    }
    
    @objc
    func panGestureAction(_ panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: view)
        
        switch panGesture.state {
        case .began:
            originalPosition = view.center
            currentPositionTouched = panGesture.location(in: view)
        case .changed:
            view.frame.origin = CGPoint(
                x: translation.x,
                y: translation.y
            )
        case .ended:
            let velocity = panGesture.velocity(in: view)
            
            if velocity.y >= 1500 {
                UIView.animate(withDuration: 0.2
                    , animations: {
//                        self.view.frame.origin = CGPoint(
//                            x: self.view.frame.origin.x,
//                            y: self.view.frame.size.height
//                        )
                }, completion: { (isCompleted) in
                    if isCompleted {
                        self.dismiss(animated: false, completion: nil)
                    }
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.center = self.originalPosition!
                })
            }
        default:
            break
        }
        
        didHideTopBar?()
    }
}
