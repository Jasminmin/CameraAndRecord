//
//  CameraViewController.swift
//  CloudPhoto
//
//  Created by Rebecca on 2019/10/5.
//  Copyright © 2019 Jasmine. All rights reserved.
//

import UIKit
import Photos

class CameraViewController: UIViewController {
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var capturePreviewView: UIView!
    @IBOutlet weak var photoModeButton: UIButton!
    @IBOutlet weak var videoModeButton: UIButton!
    @IBOutlet weak var toggleCameraButton: UIButton!
    @IBOutlet weak var toggleFlashButton: UIButton!
    
    let cameraController = CameraController()
    
    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewDidLoad() {
        func configureCameraController() {
            cameraController.prepare {(error) in if let error = error {
                print(error)
            }
            try? self.cameraController.displayPreview(on: self.capturePreviewView)
            }
        }
    
        func styleCaptureButton() {
            captureButton.layer.borderColor = UIColor(red: 77/255, green: 105/255, blue: 149/255, alpha: 1).cgColor
            captureButton.layer.borderWidth = 3
            captureButton.layer.cornerRadius = min(captureButton.frame.width, captureButton.frame.height) / 2
        }
        styleCaptureButton()
        configureCameraController()
    }
    
    @IBAction func toggleFlash(_ sender: UIButton) {
        if cameraController.flashMode == .on {
            cameraController.flashMode = .off
            toggleFlashButton.setImage(#imageLiteral(resourceName: "Flash Off Icon"), for: .normal)
        }
        else{
            cameraController.flashMode = .on
            toggleFlashButton.setImage(#imageLiteral(resourceName: "Flash On Icon"), for: .normal)
        }
    }
    
    @IBAction func switchCameras(_ sender: UIButton) {
        do {
               try cameraController.switchCameras()
           }
        
        catch {
               print(error)
        }
        
        switch cameraController.currentCameraPosition {
        case .some(.front):
            toggleCameraButton.setImage(#imageLiteral(resourceName: "Front Camera Icon"), for: .normal)
        
        case .some(.rear):
            toggleCameraButton.setImage(#imageLiteral(resourceName: "Rear Camera Icon"), for: .normal)
        
        case .none:
            return
        }
    }
    
    @IBAction func captureImage(_ sender: UIButton) {
        cameraController.captureImage {
            (image, error) in guard let image = image else {
                print(error ?? "Image capture error")
                return
            }
            try? PHPhotoLibrary.shared().performChangesAndWait {
                PHAssetChangeRequest.creationRequestForAsset(from: image)
            }
        }
    }
    
    
    // button that send value to ViewController
//    @IBAction func takeFileBtn(_ sender: Any) {
//        if let ViewController = self.tabBarController?.viewControllers?[0] as? ViewController{
//            ViewController.FileNum = ViewController.FileNum + 1
//            ViewController.fileNumLabel.text = String(ViewController.FileNum)
//        }
//    }
//
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
