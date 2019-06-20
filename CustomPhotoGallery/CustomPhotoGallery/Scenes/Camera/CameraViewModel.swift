//
//  CameraViewModel.swift
//  CustomPhotoGallery
//
//  Created by nguyen.duc.huyb on 6/19/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import AVFoundation
import Photos

final class CameraViewModel: NSObject {
    
    // Step 1: Define Instance Variables
    private var captureSession: AVCaptureSession!
    private var stillImageOutput: AVCapturePhotoOutput!
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    private var currentLocation: CLLocation!
    
    private var didChange: ((AVCaptureVideoPreviewLayer) -> Void)?
    private var didPreviewPhoto: ((UIImage) -> Void)?
    
    func bind(didChange: @escaping (AVCaptureVideoPreviewLayer) -> Void) {
        self.didChange = didChange
    }
    
    func bindPhotoPreview(didPreviewPhoto: @escaping (UIImage) -> Void) {
        self.didPreviewPhoto = didPreviewPhoto
    }
    
    func reloadData() {
        setupCamera()
        setupLocationManager()
    }
    
    private func setupCamera() {
        // Step 2: Setup Session
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        // Step 3: Select Input Device
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
            else {
                print("Unable to access back camera!")
                return
        }
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            
            // Step 4: Configure the Output
            stillImageOutput = AVCapturePhotoOutput()
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
    }
    
    // Step 5: Configure the Live Preview
    private func setupLivePreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoPreviewLayer.videoGravity = .resizeAspect
        videoPreviewLayer.connection?.videoOrientation = .portrait
        
        //Step 6: Start the Session on the background thread
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            self.captureSession.startRunning()
            
            //Step 7: Size the Preview Layer to fit the Preview View
            self.didChange?(self.videoPreviewLayer)
        }
    }
    
    func stopRunningSession() {
        captureSession.stopRunning()
    }
}

extension CameraViewModel: AVCapturePhotoCaptureDelegate {
    func capturePhoto() {
        // Step 8: Taking the picture
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }
    
    // Step 9: Process the captured photo
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation()
            else { return }
        
        guard let capturedImage = UIImage(data: imageData) else { return }
        didPreviewPhoto?(capturedImage)
        
        // Save Captured Image in Photo Library
        PHPhotoLibrary.saveImage(image: capturedImage, location: currentLocation)
    }
}

extension CameraViewModel: LocationUpdateProtocol {
    // Setup Location Manager
    private func setupLocationManager() {
        let LocationMgr = UserManager.shared
        LocationMgr.delegate = self
    }
    
    func locationDidUpdateToLocation(location: CLLocation) {
        currentLocation = location
        print("Latitude : \(self.currentLocation.coordinate.latitude)")
        print("Longitude : \(self.currentLocation.coordinate.longitude)")
    }
}
