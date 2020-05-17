//
//  AboutViewController.swift
//  BullsEye
//
//  Created by Olawunmi GEORGE on 5/12/20.
//  Copyright © 2020 Olawunmi GEORGE. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {

    @IBOutlet weak var webKitView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = Bundle.main.url(forResource: "BullsEye"
            , withExtension: "html")
        {
            let request = URLRequest(url: url)
            webKitView.load(request)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeAbout(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
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
