//
//  ViewController.swift
//  OSX-client-cam
//
//  Created by Remi Robert on 22/04/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Cocoa
import Foundation
import AVFoundation

class ViewController: NSViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    private let session: AVCaptureSession = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private let imageOutput = AVCaptureVideoDataOutput()
    @IBOutlet weak var previewView: NSView!
    @IBOutlet weak var imageView: NSImageView!

    func captureOutput(_ captureOutput: AVCaptureOutput!,
                       didOutputSampleBuffer sampleBuffer: CMSampleBuffer!,
                       from connection: AVCaptureConnection!) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return}
        let ciimage = CIImage(cvPixelBuffer: pixelBuffer)
        let rep = NSCIImageRep(ciImage: ciimage)
        let image = NSImage(size: self.previewLayer!.frame.size)
        image.addRepresentation(rep)
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }

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
        imageOutput.setSampleBufferDelegate(self, queue: DispatchQueue.main)
        if session.canAddOutput(imageOutput) {
            session.addOutput(imageOutput)
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        guard let previewLayer = previewLayer else {return}
        let myView:NSView = self.view
        previewLayer.frame = myView.bounds
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.previewView.layer?.addSublayer(previewLayer)
        session.startRunning()
    }
}
