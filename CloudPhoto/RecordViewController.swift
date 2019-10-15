//
//  RecordViewController.swift
//  CloudPhoto
//
//  Created by Rebecca on 2019/10/5.
//  Copyright © 2019 Jasmine. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController {
    
    @IBOutlet weak var listenView: UIImageView!
    var recordButton: UIButton!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    let fileNameController = FileNameController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 確認使用者開放錄音權限
        recordingSession = AVAudioSession.sharedInstance()

        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.loadRecordingUI()
                    } else {
                        print("Failed to record!")
                    }
                }
            }
        } catch {
            print("Failed to record!")
        }
    }
    
    func loadRecordingUI() {
        recordButton = UIButton(frame: CGRect(x: 153, y: 512, width: 68, height: 68))
        recordButton.setImage(#imageLiteral(resourceName: "record"), for: .normal)
        recordButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        recordButton.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
        view.addSubview(recordButton)
        listenView.image = UIImage(named: "listen.png")
    }
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("voice/" + fileNameController.dateString() + ".m4a")
        print(fileNameController.dateString() + ".m4a" + " has been recorded.")

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self as? AVAudioRecorderDelegate
            audioRecorder.record()

            recordButton.setImage(#imageLiteral(resourceName: "recording"), for: .normal)
            listenView.image = UIImage(named: "listening.png")
        } catch {
            finishRecording(success: false)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil

        if success {
            recordButton.setImage(#imageLiteral(resourceName: "record"), for: .normal)
            listenView.image = UIImage(named: "listen.png")
        } else {
            recordButton.setImage(#imageLiteral(resourceName: "record"), for: .normal)
            listenView.image = UIImage(named: "listen.png")
            // recording failed :(
        }
    }
    
    @objc func recordTapped() {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    /*
    @IBAction func recordVoiceBtn(_ sender: Any) {
        
        // 傳值
        if let ViewController = self.tabBarController?.viewControllers?[0] as? ViewController{
            ViewController.FileNum = ViewController.FileNum + 1
            ViewController.fileNumLabel.text = String(ViewController.FileNum)
        }
    }
    */

}
