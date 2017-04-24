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

    @IBOutlet weak var segment: NSSegmentedControl!
    private let session: AVCaptureSession = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private let imageOutput = AVCaptureVideoDataOutput()
    @IBOutlet weak var previewView: NSView!
    @IBOutlet weak var imageView: NSImageView!

    private var capture: Bool = false

    func captureOutput(_ captureOutput: AVCaptureOutput!,
                       didOutputSampleBuffer sampleBuffer: CMSampleBuffer!,
                       from connection: AVCaptureConnection!) {

        if !capture {
            return
        }
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return}
        let ciimage = CIImage(cvPixelBuffer: pixelBuffer)
        let rep = NSCIImageRep(ciImage: ciimage)
        let image = NSImage(size: NSSize(width: self.previewView!.frame.size.width * 2, height: self.previewView!.frame.size.height * 2))
        image.addRepresentation(rep)

        let path = NSViewScreenshots.save(image)

        guard let data = image.tiffRepresentation else {return}

        DispatchQueue.main.async {
            self.imageView.image = NSImage(data: data)
        }
        self.capture = false

        if segment.integerValue < 2 {
            var fakePath = ""
            if segment.integerValue == 0 {
                fakePath = "/Users/remirobert/dev/mobility-api/files/025E9ABC-FD9D-41C5-986A-FF43BDB2EFB1"

            } else {
                fakePath = "/Users/remirobert/dev/mobility-api/files/9D50CF8C-54E6-4AF1-9C05-8727EC3F6D1F"
            }
            self.capture = false
            Command.analyse(fakePath)
            return
        } else {
            Command.analyse(path)
        }
//        APIService.shared.upload(path: path!)
    }

    override func viewDidAppear() {
        super.viewDidAppear()

        session.sessionPreset = AVCaptureSessionPresetMedium
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

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "capture"),
                                               object: nil,
                                               queue: nil) { [weak self] _ in
            print("get capture event socket")
            self?.capture = true
        }
    }
}
