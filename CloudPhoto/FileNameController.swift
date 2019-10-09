//
//  FileNameController.swift
//  CloudPhoto
//
//  Created by Rebecca on 2019/10/9.
//  Copyright © 2019 Jasmine. All rights reserved.
//

import UIKit

class FileNameController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func dateString() -> String{
        let now:Date = Date()
        let currentDate:DateFormatter = DateFormatter()
        currentDate.dateFormat = "MMddHHmmssSS"
        let dateString:String = currentDate.string(from: now)
        return dateString
        
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
