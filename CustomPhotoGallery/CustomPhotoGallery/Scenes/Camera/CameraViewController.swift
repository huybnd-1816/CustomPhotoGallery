//
//  CameraViewController.swift
//  CustomPhotoGallery
//
//  Created by nguyen.duc.huyb on 6/18/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

final class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    @IBOutlet private weak var cameraPreviewView: UIView!
    @IBOutlet private weak var photoPreviewImageView: UIImageView!

    private var viewModel: CameraViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Step 10: Clean up
        viewModel.stopRunningSession()
    }
    
    private func config() {
        viewModel = CameraViewModel()
        viewModel.reloadData()
        viewModel.bind { [weak self] videoPreviewLayer in
            guard let self = self else { return }
            //Step 7: Size the Preview Layer to fit the Preview View
            DispatchQueue.main.async {
                self.cameraPreviewView.layer.addSublayer(videoPreviewLayer)
                videoPreviewLayer.frame = self.cameraPreviewView.bounds
            }
        }
        
        viewModel.bindPhotoPreview { [weak self] image in
            guard let self = self else { return }
            self.photoPreviewImageView.image = image
        }
    }
    
    @IBAction func handleTakePhotoButtonTapped(_ sender: Any) {
        // Step 8: Taking the picture
        view.flashAnimation()
        viewModel.capturePhoto()
    }
    
    @IBAction func handleCancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
