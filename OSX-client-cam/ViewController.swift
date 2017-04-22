//
//  ViewController.swift
//  OSX-client-cam
//
//  Created by Remi Robert on 22/04/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Cocoa
import AVFoundation

class ViewController: NSViewController {

    private let session: AVCaptureSession = AVCaptureSession()

    override func viewDidAppear() {
        super.viewDidAppear()

        session.sessionPreset = AVCaptureSessionPresetLow
        let device:AVCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)

        let possibleCameraInput: AnyObject? = try! AVCaptureDeviceInput.init(device: device)
        if let backCameraInput = possibleCameraInput as? AVCaptureDeviceInput {
            if session.canAddInput(backCameraInput) {
                session.addInput(backCameraInput)
            }
        }

        let previewLayer:AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
        let myView:NSView = self.view
        previewLayer.frame = myView.bounds
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.view.layer?.addSublayer(previewLayer)
        session.startRunning()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
        }
    }
}
