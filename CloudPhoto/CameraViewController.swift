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
    @IBOutlet weak var toggleCameraButton: UIButton!
    @IBOutlet weak var toggleFlashButton: UIButton!
    
    let cameraController = CameraController()
    let fileNameController = FileNameController()
    
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
            //存在原生相簿裡
            /*
            try? PHPhotoLibrary.shared().performChangesAndWait {
                PHAssetChangeRequest.creationRequestForAsset(from: image)
                print("Photo taked!")
            }
            */
            let fileManager = FileManager.default
            let path = NSHomeDirectory() + "/Documents"
            let dstPhoto: String = path + "/photo"
            let photoName = self.fileNameController.dateString() + ".jpeg"
            let photoFile: String = dstPhoto + "/" + photoName
            //let storePhoto: NSData = image.pngData()! as NSData
            let storePhoto = image.jpegData(compressionQuality: 1.0)!
            if fileManager.createFile(atPath: photoFile, contents: storePhoto as Data, attributes: nil){
                print(photoName + " has been stroed.")
            }else{
                print(photoName + " has NOT been stroed.")
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
