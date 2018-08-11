//
//  ViewController.swift
//  Object Recognition
//
//  Created by Parshva Shah on 11/08/18.
//  Copyright © 2018 Parshva. All rights reserved.
//

import UIKit
import AVKit
import Vision

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        guard let input  = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        view.layer.addSublayer(previewLayer)
        captureSession.startRunning()
        
        previewLayer.frame = view.frame
        let dataOutput = AVCaptureVideoDataOutput()
        captureSession.addOutput(dataOutput)
        
        //let request = VNCoreMLRequest(model: <#T##VNCoreMLModel#>, completionHandler: <#T##VNRequestCompletionHandler?##VNRequestCompletionHandler?##(VNRequest, Error?) -> Void#>)
        //VNImageRequestHandler(cgImage: CGImage,options:[:].perform[requests:VNRequest[])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

