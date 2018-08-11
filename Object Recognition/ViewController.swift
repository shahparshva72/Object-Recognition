//
//  ViewController.swift
//  Object Recognition
//
//  Created by Parshva Shah on 11/08/18.
//  Copyright © 2018 Parshva. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import CoreML
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
        dataOutput.setSampleBufferDelegate(self as? AVCaptureVideoDataOutputSampleBufferDelegate, queue: DispatchQueue(label:"videoQueue"))
        captureSession.addOutput(dataOutput)

    }
    
    func captureOutput(_ output:AVCaptureOutput,didOutput sampleBuffer: CMSampleBuffer,from connection:AVCaptureConnection){
        guard let pixelBuffer: CVPixelBuffer = (CMSampleBufferGetDataBuffer(sampleBuffer) as! CVPixelBuffer) else {
            return
        }
        
        guard let model  = try? VNCoreMLModel(for: SqueezeNet().model) else {return }
        let request = VNCoreMLRequest(model: model){
            (finishedReq,err) in
            
           // print(finishedReq.results!)
            
            guard let results = finishedReq.results as? [VNClassificationObservation] else {return }
            
            guard let firstObservation = results.first else {return }
            
            print(firstObservation.identifier,firstObservation.confidence)
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer,options:[ : ]).perform([request])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

