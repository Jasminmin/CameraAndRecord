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

