//
//  ShowItemViewController.swift
//  CloudPhoto
//
//  Created by Rebecca on 2019/10/5.
//  Copyright © 2019 Jasmine. All rights reserved.
//

import UIKit

class ShowItemViewController: UIViewController {

    @IBOutlet weak var showNumLabel: UILabel!
    var ShowNum: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        showNumLabel.text = ShowNum
        // Do any additional setup after loading the view.
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
