//
//  ViewController.swift
//  CloudPhoto
//
//  Created by Rebecca on 2019/10/2.
//  Copyright © 2019 Jasmine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fileNumLabel: UILabel!
    var FileNum: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var dstPhoto, dstVoice: String
        let fileManager = FileManager.default
        let path = NSHomeDirectory() + "/Documents"
        dstPhoto = path + "/photo"
        dstVoice = path + "/voice"
        
        //確認相片資料夾是否存在
        if fileManager.fileExists(atPath: dstPhoto){return}
        do{
            try fileManager.createDirectory(atPath: dstPhoto, withIntermediateDirectories: true, attributes: nil)
            print("Success to build /document/photo")
        }catch{
            print("Fail to build photo directory")
        }
        
        //確認錄音資料夾是否存在
        if fileManager.fileExists(atPath: dstVoice){return}
        do{
            try fileManager.createDirectory(atPath: dstVoice, withIntermediateDirectories: true, attributes: nil)
            print("Success to build /document/voice")
        }catch{
            print("Fail to build voice directory")
        }
        
    }

    @IBAction func showFileDetail(_ sender: Any) {
        self.performSegue(withIdentifier: "showNumSegue", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNumSegue" {
            let showVC = segue.destination as! ShowItemViewController
            showVC.ShowNum = fileNumLabel.text!
        }
    }
}

